/**
 * Copyright (c) 2009-2010, The HSL Contributors. Most notable contributors, in order of appearance: Pimm Hogeling, Edo Rivai,
 * Owen Durni.
 *
 * This file is part of HSL. HSL, pronounced "hustle", stands for haXe Signaling Library.
 *
 * HSL is free software. Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *
 *   * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
 *     disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HSL CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE HSL
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * End of conditions.
 * 
 * The license of HSL might change in the near future, most likely to match the license of the haXe core libraries.
 */
package org.hsl.haxe.direct;
import haxe.PosInfos;
import org.hsl.haxe.Signaler;
import org.hsl.haxe.verification.AllAcceptingVerifier;
import org.hsl.haxe.verification.DataVerifier;
import org.hsl.haxe.verification.NonNullAcceptingVerifier;
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.haxe.Subject;

/**
 * The direct signaler is the most common implementation of the signaler interface. Signals are directly dispatched by the
 * subject.
 */
class DirectSignaler<D> implements Signaler<D> {
	/**
	 * The signalers this signaler will bubble to.
	 */
	private var bubblingTargets:List<Signaler<D>>;
	/**
	 * The data verifier used to verify data that is to be sent in a signal, before actually dispatching the signal. If the data
	 * does not pass the verification, the signaler will throw an exception.
	 * 
	 * You could use the data verifier to manually verify data before passing it to the dispatch method. This way you can prevent
	 * exceptions from being thrown.
	 */
	public var dataVerifier(default, null):DataVerifier<D>;
	public var hasSlots(getHasSlots, null):Bool;
	/**
	 * The sentinel "slot". The sentinel is not a real slot, as it is never called. Rather it is the value before the first node
	 * and after the last node. It contains logic that helps the direct signaler working with the linked list structure.
	 */
	private var sentinel:Sentinel<D>;
	public var subject(default, null):Subject;
	/**
	 * The fully qualified class name of the subject.
	 */
	private var subjectClassName(getSubjectClassName, #if as3 setSubjectClassName #else null #end):String;
	/**
	 * Creates a new direct signaler. The passed subject will be considered the subject that owns the signaler, and will be
	 * allowed to call the dispatch method of the signaler. If the rejectNullData flag is set, a non-null accepting verifier will
	 * be used to verify data passed to the dispatch method of the signaler. If the flag is not set, an all accepting verifier
	 * will be used.
	 */
	public function new(subject:Subject, ?rejectNullData:Null<Bool>):Void {
		// If the passed subject is null, throw an exception. Having null for a subject might produce null object reference errors
		// later on: when the listeners use the produced signals.
		if (subject == null) {
			// TODO: throw a more exception instead of this lame one.
			throw "The subject argument must be non-null.";
		}
		this.subject = subject;
		// If the rejectNullData flag is set, use the non-null accepting verifier.
		dataVerifier =
			untyped if (rejectNullData) {
				new NonNullAcceptingVerifier<D>();
			// If the rejectNullData flag isn't set, use an all accepting verifier.
			} else {
				new AllAcceptingVerifier<D>();
			}
		bubblingTargets = new List<Signaler<D>>();
		// Prepare the linked list structure by instantiating the sentinel.
		sentinel = new Sentinel<D>();
	}
	public function addBubblingTarget(value:Signaler<D>):Void {
		bubblingTargets.add(value);
	}
	public function addNiladicSlot(method:Void -> Void):Slot<D> {
		return sentinel.add(new NiladicSlot<D>(method));
	}
	public function addSlot(method:Signal<D> -> Void):Slot<D> {
		return sentinel.add(new RegularSlot<D>(method));
	}
	public function addSimpleSlot(method:D -> Void): Slot<D> {
		return sentinel.add(new SimpleSlot<D>(method));
	}
	private /*inline*/ function bubble(data:D, initialSubject:Subject):Void {
		// Call the dispatch method of all the bubbling targets.
		for (target in bubblingTargets) {
			target.dispatch(data, initialSubject);
		}
	}
	public function dispatch(?data:D, ?initialSubject:Subject, ?positionInformation:PosInfos):Void {
		// Check whether the caller of this method is the subject of this signaler, as this method should only be called by the
		// subject. Three notes here. One, the following line checks whether the caller is of the same type as the subject, which
		// does not necessarily mean it's the same instance. This is the expected behavior, as it is consistent with private
		// fields. Two, one could hack his or her way around this check. How to do this should be obvious. The check is not
		// designed to be unhackable; rather it is designed to prevent developers from accidentally misapplying HSL. Three, the
		// line below contains a fairly nasty hack around the check in case the name of the method that called this one is
		// "bubble". This is obviously far from perfect, but this allows us to add the bubbling functionality without polluting the
		// API.
		if (positionInformation.methodName != "bubble" && positionInformation.className != subjectClassName) {
			// TODO: throw a more exception instead of this lame one.
			throw "The dispatch method may only be called by the subject.";
		}
		// Verify the passed data.
		verifyData(data);
		// Set the initial subject of the signal to the passed initial subject, or to the subject of this signaler if one was
		// not passed.
		var initialSubject:Subject = 
			if (initialSubject == null) {
				subject;
			} else {
				initialSubject;
			}
		// Dispatch the signal.
		var status:SlotCallStatus = dispatchUnsafe(data, initialSubject);
		// Bubble the signal, if propagation and bubbling have not been stopped.
		if (status.propagationStopped == false && status.bubblingStopped == false) {
			bubble(data, initialSubject);
		}
	}
	/**
	 * Dispatches a signal without verifying the data, and returns the resulting slot call status.
	 */
	private /*inline*/ function dispatchUnsafe(data:D, initialSubject:Subject):SlotCallStatus {
		var status:SlotCallStatus = new SlotCallStatus();
		sentinel.callConnected(data, subject, initialSubject, status);
		return status;
	}
	private function getHasSlots():Bool {
		return sentinel.isConnected;
	}
	/**
	 * Gets the fully qualified class name of the subject.
	 */
	private inline function getSubjectClassName():String {
		// As both Type.getClassName and Type.getClass can be quite expensive, we only call them the first time this method is
		// called and store the result. We'll just use the stored result from that point on.
		return
			if (subjectClassName == null) {
				subjectClassName = Type.getClassName(
					// If the subject is a class, the result will be the name of that class.
					untyped if (Std.is(subject, Class)) {
						subject;
					// If the subject is an instance of a class, the result will be the name of the class that it is an instance of.
					} else {
						Type.getClass(subject);
					}
				);
			} else {
				subjectClassName;
			}
	}
	public function removeBubblingTarget(value:Signaler<D>):Void {
		bubblingTargets.remove(value);
	}
	public function removeNiladicSlot(method:Void -> Void):Void {
		sentinel.remove(new NiladicSlot<D>(method));
	}
	public function removeSlot(method:Signal<D> -> Void):Void {
		sentinel.remove(new RegularSlot<D>(method));
	}
	public function removeSimpleSlot(method:D -> Void):Void {
		sentinel.remove(new SimpleSlot<D>(method));
	}
	// Because of a bug in the haXe compiler version 2.05, this method is needed when compiling to AS3. This has been fixed, but
	// the latest official build of the compiler still has this bug. This method could be removed if a new official build of the
	// haXe compiler is released. For more information, see http://code.google.com/p/haxe/issues/detail?id=47
	#if as3
	private function setSubjectClassName(value:String):String {
		return subjectClassName = value;
	}
	#end
	#if debug
	private function toString():String {
		return "[Signaler hasSlots=" + hasSlots + "]";
	}
	#end
	/**
	 * Verifies the passed data using the data verifier of the signaler, and throws an acception if the passed data does not pass
	 * the verification.
	 */
	private /*inline*/ function verifyData(data:D):Void {
		var verificationResult:String = dataVerifier.verify(data);
		if (verificationResult != null) {
			throw verificationResult;
		}
	}
}
/**
 * A sentinel "slot". The sentinel is not a real slot, as it is never called. Rather it is the value before the first node and
 * after the last node. It contains logic that helps the direct signaler working with the linked list structure.
 */
private class Sentinel<D> extends LinkedSlot<D> {
	/**
	 * Indicates whether this sentinel is connected to actual slots (true), or not (false).
	 */
	public var isConnected(getIsConnected, null):Bool;
	public function new():Void {
		super();
		next = previous = this;
	}
	/**
	 * Inserts a slot between the sentinel and the previous slot.
	 */
	public inline function add(value:LinkedSlot<D>):LinkedSlot<D> {
		value.next = this;
		value.previous = previous;
		previous = previous.next = value;
		return value;
	}
	/**
	 * Calls every slot connected to the sentinel.
	 */
	public inline function callConnected(data:D, currentSubject:Subject, initialSubject:Subject, slotCallStatus:SlotCallStatus):Void {
		var node:LinkedSlot<D> = next;
		while (node != this && slotCallStatus.propagationStopped == false) {
			node.call(data, currentSubject, initialSubject, slotCallStatus);
			node = node.next;
		}
	}
	/**
	 * Determines whether this sentinel is connected to actual slots (true), or not (false).
	 */
	private inline function getIsConnected():Bool {
		return next != this;
	}
	/**
	 * Removes a slot connected to the sentinel.
	 * 
	 * The sentinel will look for a slot equal to the passed value directy or indirectly connected to it, and destroy it. Returns
	 * true if a slot equal to the passed value is found and destroyed; false otherwise.
	 */
	public inline function remove(value:LinkedSlot<D>):Void {
		var node:LinkedSlot<D> = next;
		while (node != this) {
			if (node.determineEquality(value)) {
				node.destroy();
				break;
			}
			node = node.next;
		}
	}
}
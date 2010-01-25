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
	 * The data verifier used to verify data that is to be sent in a signal, before actually dispatching the signal. If the data
	 * does not pass the verification, the signaler will throw an exception.
	 * 
	 * You could use the data verifier to manually verify data before passing it to the dispatch method. This way you can prevent
	 * exceptions from being thrown.
	 */
	public var dataVerifier(default, null):DataVerifier<D>;
	public var hasSlots(getHasSlots, null):Bool;
	private var sentinel:Sentinel<D>;
	public var subject(default, null):Subject;
	/**
	 * The fully qualified class name of the subject.
	 */
	private var subjectClassName(getSubjectClassName, setSubjectClassName):String;
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
		// Prepare the linked list structure by instantiating the sentinel.
		sentinel = new Sentinel<D>();
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
	public function dispatch(?data:D, ?positionInformation:PosInfos):Void {
		// Check whether the caller of this method is the subject of this signaler, as this method should only be called by the
		// subject. Two notes here. One, the following line checks whether the caller is of the same type as the subject, which
		// does not necessarily mean it's the same instance. This is the expected behavior, as it is consistent with private
		// fields. Two, one could hack his or her way around this check. How to do this should be obvious. The check is not
		// designed to be unhackable; rather it is designed to prevent developers from accidentally misapplying HSL.
		if (positionInformation.className != subjectClassName) {
			// TODO: throw a more exception instead of this lame one.
			throw "The dispatch method may only be called by the subject.";
		}
		// Verify the passed data.
		verifyData(data);
		// Dispatch the signal.
		dispatchUnsafe(data, subject);
	}
	/**
	 * Dispatches a signal without verifying the data.
	 */
	private /*inline*/ function dispatchUnsafe(data:D, initialSubject:Subject):Void {
		sentinel.callConnected(data, subject, initialSubject);
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
		if (subjectClassName == null) {
			// The following line is, to my knowledge, the only way to get the fully qualified class name of an object without the
			// use of target-specific code. It could be faster though, because the combination of the two methods is not optimal.
			subjectClassName = Type.getClassName(Type.getClass(subject));
		}
		return subjectClassName;
	}
	public function removeNiladicSlot(method:Void -> Void):Bool {
		return sentinel.remove(new NiladicSlot<D>(method));
	}
	public function removeSlot(method:Signal<D> -> Void):Bool {
		return sentinel.remove(new RegularSlot<D>(method));
	}
	public function removeSimpleSlot(method:D -> Void):Bool {
		return sentinel.remove(new SimpleSlot<D>(method));
	}
	private inline function setSubjectClassName(value:String):String {
		return subjectClassName = value;
	}
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
	public inline function callConnected(data:D, currentSubject:Subject, initialSubject:Subject):Void {
		var node:LinkedSlot<D> = next;
		while (node != this) {
			node.call(data, currentSubject, initialSubject);
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
	public inline function remove(value:LinkedSlot<D>):Bool {
		var node:LinkedSlot<D> = next;
		var result:Bool = false;
		while (node != this) {
			if (node.determineEquality(value)) {
				node.destroy();
				result = true;
				break;
			}
			node = node.next;
		}
		return result;
	}
}
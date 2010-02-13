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
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.haxe.Subject;

/**
 * A slot that can be used for Signal<D> -> Void methods.
 */
class RegularSlot<D> extends LinkedSlot<D> {
	private var method:Signal<D> -> Void;
	/**
	 * Creates a new regular slot.
	 */
	public function new(method:Signal<D> -> Void):Void {
		super();
		this.method = method;
	}
	public override function call(data:D, currentSubject:Subject, initialSubject:Subject, slotCallStatus:SlotCallStatus):Void {
		var signal:Signal<D> = new Signal<D>(data, this, currentSubject, initialSubject);
		method(signal);
		// If the bubbling stopped property of the signal is set, set that property in slot call status.
		if (signal.bubblingStopped) {
			slotCallStatus.bubblingStopped = true;
		}
		// If the propagation stopped property of the signal is set, set that property in slot call status.
		if (signal.propagationStopped) {
			slotCallStatus.propagationStopped = true;
		}
	}
	#if as3 public #else private #end override function determineEquality(slot:Slot<D>):Bool {
		// Since the first check makes sure the type of the passed slot is equal to this one, it is safe to assume that the passed
		// slot has a method property in the second. However, AS3 compilers don't like this. We have to cast it explicitly for
		// them.
		#if as3
		return Std.is(slot, RegularSlot) && Reflect.compareMethods(cast(slot, RegularSlot<Dynamic>).method, method);
		#else
		return Std.is(slot, RegularSlot) && Reflect.compareMethods((untyped slot).method, method);
		#end
	}
}
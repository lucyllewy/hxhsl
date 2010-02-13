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
import org.hsl.haxe.Slot;
import org.hsl.haxe.Subject;

/**
 * A doubly linked slot, used by the direct signaler. The slot has a reference to the next and the previous slot in the list.
 */
class LinkedSlot<D> implements Slot<D> {
	public var destroyed(default, null):Bool;
	// It seems that in AS3 it is not allowed to write to private (protected) fields in ways that are allowed in haXe. Therefore,
	// these fields are public in AS3.
	#if as3 public #else private #end var next:LinkedSlot<D>;
	#if as3 public #else private #end var previous:LinkedSlot<D>;
	public function new():Void {
		destroyed = false;
	}
	public function call(data:D, currentSubject:Subject, initialSubject:Subject, slotCallStatus:SlotCallStatus):Void {
	}
	/**
	 * Determines whether this slot and the passed slot are equal (true) or not (false).
	 */
	#if as3 public #else private #end function determineEquality(slot:Slot<D>):Bool {
		return false;
	}
	public function destroy():Void {
		// If this slot has already been destroyed, don't destroy it again.
		if (destroyed) {
			return;
		}
		previous.next = next;
		next.previous = previous;
		destroyed = true;
	}
	#if debug
	private function toString():String {
		return "[Slot]";
	}
	#end
}
/**
 * Copyright (c) 2009-2010, The HSL Contributors. Most notable contributors, in order of appearance: Pimm Hogeling, Edo Rivai,
 * Owen Durni, Niel Drummond.
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
package org.hsl.haxe;
import org.hsl.haxe.direct.SlotCallStatus;

/**
 * Slots represent the relation between a signaler, and one of its listeners. 
 */
interface Slot<D> {
	/**
	 * Indicates whether the slot has been halted (true) or not (false).
	 */
	public var halted(default, null):Bool;
	/**
	 * Calls the slot to notify a listener.
	 */
	public function call(data:D, currentSubject:Subject, initialSubject:Subject, slotCallStatus:SlotCallStatus):Void;
	/**
	 * Destroys the slot: removes it from the signaler it is in. Slots cannot be undestroyed. To temporary suspend the slot from
	 * notifying listeners, use the halt method. Once destroyed, the call method of the slot might malfunction, or stop
	 * functioning at all.
	 */
	public function destroy():Void;
	/**
	 * Halts the slot. The slot will ignore any calls, and will not notify any listeners, until the resume method is called. If
	 * the slot was already halted, calling this method has no effect.
	 */
	public function halt():Void;
	/**
	 * Resumes the slot, after it has been halted by calling the halt method. If the slot was not halted, calling this method has
	 * no effect.
	 */
	public function resume():Void;
}
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
package org.hsl.haxe;
import haxe.PosInfos;

/**
 * A null object implementation of the signaler interface.
 */
class NullSignaler<D> implements Signaler<D> {
	public var subject(default, null):Subject;
	public var hasSlots(getHasSlots, null):Bool;
	/**
	 * Creates a new null signaler.
	 */
	public function new(subject:Subject):Void {
		this.subject = subject;
	}
	public function addBubblingTarget(value:Signaler<D>):Void {
	}
	public function addNiladicSlot(method:Void -> Void):Slot<D> {
		return new NullSlot<D>();
	}
	public function addSlot(method:Signal<D> -> Void):Slot<D> {
		return new NullSlot<D>();
	}
	public function addSimpleSlot(method:D -> Void):Slot<D> {
		return new NullSlot<D>();
	}
	public function dispatch(?data:D, ?initialSubject:Subject, ?positionInformation:PosInfos):Void {
	}
	private function getHasSlots():Bool {
		return false;
	}
	public function removeBubblingTarget(value:Signaler<D>):Bool {
		return false;
	}
	public function removeNiladicSlot(method:Void -> Void):Bool {
		return false;
	}
	public function removeSlot(method:Signal<D> -> Void):Bool {
		return false;
	}
	public function removeSimpleSlot(method:D -> Void):Bool {
		return false;
	}
	#if debug
	private function toString():String {
		return "[Signaler hasSlots=false]";
	}
	#end
}
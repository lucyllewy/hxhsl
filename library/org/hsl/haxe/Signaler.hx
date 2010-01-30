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
 * Signalers are objects owned by subjects. Subjects notify their environment of internal state changes, by dispatching signals
 * through their signalers.
 * 
 * Listeners can add slots to signalers. Those slots will be stored inside the signaler.
 */
interface Signaler<D> {
	public var subject(default, null):Subject;
	/**
	 * Indicates whether the signaler has any slots in it.
	 * 
	 * This property can be used for speed optimizations. If a signaler has no slots, its subject does not have to calculate a
	 * value if that value will only be sent in a signal.
	 */
	public var hasSlots(getHasSlots, null):Bool;
	/**
	 * Adds a bubbling target. The signaler will bubble to this bubbling target in a bubbling process.
	 */
	public function addBubblingTarget(value:Signaler<D>):Void;
	/**
	 * Adds a slot containing a method that accepts nothing, and returns nothing, and returns that slot. The slot can be removed
	 * by calling the removeNiladicSlot method of the signaler, or the destroy method of the returned slot.
	 * 
	 * Using niladic slots, you cannot access the data sent in the signals. If you need that data, use the addSlot method or the
	 * addSimpleSlot method. The former is more advanced than the latter.
	 */
	public function addNiladicSlot(method:Void -> Void):Slot<D>;
	/**
	 * Adds a slot containing a method that accepts a signal, and returns nothing, and returns that slot. The slot can be removed
	 * by calling the removeSlot method of the signaler, or the destroy method of the returned slot.
	 * 
	 * In a lot of cases, there is no need to accept the entire signal. For those cases, you could use the addNiladicSlot
	 * method or the addSimple method instead.
	 */
	public function addSlot(method:Signal<D> -> Void):Slot<D>;
	/**
	 * Adds a slot containing a method that accepts data of the type that equals the type parameter of the signaler and returns
	 * nothing, and returns that slot. The slot can be removed by calling the removeSimpleSlot method of the slot list, or the
	 * destroy method of the slot.
	 */
	public function addSimpleSlot(method:D -> Void):Slot<D>;
	/**
	 * Dispatches a signal, containing the passed data. All the listeners that added slots to this signaler will be notified,
	 * through those slots. The signal will bubble to all of the bubbling targets that were added to this signaler. This method
	 * may only be called by the subject of the signaler.
	 */
	public function dispatch(?data:D, ?initialSubject:Subject, ?positionInformation:PosInfos):Void;
	private function getHasSlots():Bool;
	/**
	 * Removes a bubbling target that was added by the addBubblingTarget method. Returns true if the removal succeeded; false if
	 * the signaler does not have the passed value as a bubbling target.
	 */
	public function removeBubblingTarget(value:Signaler<D>):Bool;
	/**
	 * Removes a slot added by the addNiladicSlot method. Returns true if the removal succeeded; false if this signaler does not
	 * have a slot with a method equal the passed one.
	 */
	public function removeNiladicSlot(method:Void -> Void):Bool;
	/**
	 * Removes a slot added by the addSlot method. Returns true if the removal succeeded; false if this signaler does not have a
	 * slot with a method equal the passed one.
	 */
	public function removeSlot(method:Signal<D> -> Void):Bool;
	/**
	 * Removes a slot added by the addSimpleSlot method. Returns true if the removal succeeded; false if this signaler does not
	 * have a slot with a method equal the passed one.
	 */
	public function removeSimpleSlot(method:D -> Void):Bool;
}
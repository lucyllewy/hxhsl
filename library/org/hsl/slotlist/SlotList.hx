package org.hsl.slotlist;
/**
 * Copyright (c) 2009 Pimm Hogeling
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
 * THIS SOFTWARE IS PROVIDED BY PIMM HOGELING "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL PIMM HOGELING
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
import org.hsl.bridge.SignalerSlotListBridge;
import org.hsl.signaler.Signaler;
import org.hsl.Signal;
/**
 * The slotlist contains all the slots that will be used to notify the listeners of a state change.
 */
interface ISlotList<D> {
	/**
	 * The number of slots currently present in this slot list.
	 */
	public var numberOfSlots(default, null):#if flash9 UInt #else Int #end;
	/**
	 * Adds a method that accepts nothing, and returns nothing, as a slot. The spreader will call that slot every time it spreads
	 * a signal, until destroyNiladic is called for that slot.
	 */
	public function createNiladic(method:Void -> Void):Void;
	/**
	 * Adds a method that accepts a signal with the same type parameter as this spreader, and returns nothing, as a slot. This
	 * spreader will call that slot every time it spreads a signal, until destroyRegular is called for that slot.
	 */
	public function createRegular(method:Signal<D> -> Void):Void;
	/**
	 * Removes a slot added by the createNiladic method. Returns true if the removal succeeded, false if this spreader does not
	 * have the passed method registered as a niladic slot.
	 */
	public function destroyNiladic(method:Void -> Void):Bool;
	/**
	 * Removes a slot added by the createRegular method. Returns true if the removal succeeded, false if this spreader does not
	 * have the passed method registered as a slot.
	 */
	public function destroyRegular(method:Signal<D> -> Void):Bool;
}
/**
 * A common ISlotList implementation.
 */
class SlotList<D> implements ISlotList<D> {
	public var numberOfSlots(default, null):#if flash9 UInt #else Int #end;
	private var slots:List<ISlot<D>>;
	public function new(signaler:ISignaler<D>):Void {
		numberOfSlots = 0;
		slots = new List<ISlot<D>>();
		signaler.advanced.connectWithSlotList(new SignalerSlotListBridge<D>(this));
	}
	public inline function callSlots(signal:Signal<D>):Void {
		for (slot in slots) {
			slot.call(signal);
		}
	}
	public function createNiladic(method:Void -> Void):Void {
		slots.add(new NiladicSlot<D>(method));
		++numberOfSlots;
	}
	public function createRegular(method:Signal<D> -> Void):Void {
		slots.add(new RegularSlot<D>(method));
		++numberOfSlots;
	}
	private inline function destroySlotByWrapper(value:ISlot<D>):Bool {
		var result:Bool = false;
		for (slot in slots) {
			if (slot.determineEquality(value)) {
				// This way of removing is obviously slower than it could be. Might be replaced.
				result = slots.remove(slot);
				--numberOfSlots;
				break;
			}
		}
		return result;
	}
	public function destroyNiladic(method:Void -> Void):Bool {
		return destroySlotByWrapper(new NiladicSlot<D>(method));
	}
	public function destroyRegular(method:Signal<D> -> Void):Bool {
		return destroySlotByWrapper(new RegularSlot<D>(method));
	}
	private function toString():String {
		return "[SlotList]";
	}
}
/**
 * The ISignalerSlotListBridge implementation used by the SlotList class.
 */
class SignalerSlotListBridge<D> implements ISignalerSlotListBridge<D> {
	private var slotList:SlotList<D>;
	public function new(slotList:SlotList<D>):Void {
		this.slotList = slotList;
	}
	public function callSlots(signal:Signal<D>):Void {
		slotList.callSlots(signal);
	}
}
/**
 * Slots contain a method. They allow the slotlist to call that method, regardless of the signature that method has.
 */
interface ISlot<D> {
	/**
	 * Calls the method inside the slot, possibly passing the passed signal.
	 */
	public function call(signal:Signal<D>):Void;
	/**
	 * Determines whether the passed slot equals this one.
	 */
	public function determineEquality(slot:ISlot<D>):Bool;
}
/**
 * The ISlot implementation for Void -> Void methods.
 */
class NiladicSlot<D> implements ISlot<D> {
	private var method:Void -> Void;
	public function new(method:Void -> Void):Void {
		this.method = method;
	}
	public function call(signal:Signal<D>):Void {
		method();
	}
	public function determineEquality(slot:ISlot<D>):Bool {
		return Std.is(slot, NiladicSlot) && Reflect.compareMethods((untyped slot).method, method);
	}
}
/**
 * The ISlot implementation for Signal<D> -> Void methods.
 */
class RegularSlot<D> implements ISlot<D> {
	private var method:Signal<D> -> Void;
	public function new(method:Signal<D> -> Void):Void {
		this.method = method;
	}
	public function call(signal:Signal<D>):Void {
		method(signal);
	}
	public function determineEquality(slot:ISlot<D>):Bool {
		return Std.is(slot, RegularSlot) && Reflect.compareMethods((untyped slot).method, method);
	}
}
/**
 * A null object implementation of the ISlotList interface.
 */
class NullSlotList<D> implements ISlotList<D> {
	public var numberOfSlots(default, null):#if flash9 UInt #else Int #end;
	public function new():Void {
		numberOfSlots = 0;
	}
	public function createNiladic(method:Void -> Void):Void {
	}
	public function createRegular(method:Signal<D> -> Void):Void {
	}
	public function destroyNiladic(method:Void -> Void):Bool {
		return false;
	}
	public function destroyRegular(method:Signal<D> -> Void):Bool {
		return false;
	}
	private function toString():String {
		return "[SlotList]";
	}
}
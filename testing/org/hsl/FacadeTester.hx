package org.hsl;
import haxe.unit.TestCase;
import org.hsl.dispatching.Dispatcher;
import org.hsl.signaler.Signaler;
import org.hsl.slotlist.SlotList;
using org.hsl.Facade;

class FacadeTester extends TestCase, implements IDispatcher {
	private var stringSignaler:ISignaler<String>;
	public var stringSlotList(default, null):ISlotList<String>;
	private var voidSignaler:ISignaler<Void>;
	public var voidSlotList(default, null):ISlotList<Void>;
	public function new():Void {
		super();
	}
	public function testInstantiateNullSlotList():Void {
		// Test the Void signaler. First, set the slotlist to null.
		voidSlotList = null;
		// Use the facade to instantiate it.
		this.instantiateNullSlotList("void");
		// Assert that it is not null.
		assertTrue(voidSlotList != null);
		// Test the String signaler. First, set the slotlist to null.
		stringSlotList = null;
		// Use the facade to instantiate it.
		this.instantiateNullSlotList("string", String);
		// Assert that it is not null.
		assertTrue(voidSlotList != null);
	}
	public function testInstantiateSignalerWithSlotList():Void {
		// Test the Void signaler. First, set the signaler and the slotlist to null.
		voidSignaler = null;
		voidSlotList = null;
		// Use the facade to instantiate both.
		this.instantiateSignalerWithSlotList("void");
		// Assert that they are both not null.
		assertTrue(voidSignaler != null);
		assertTrue(voidSlotList != null);
		// Test the String signaler. First, set the signaler and the slotlist to null.
		stringSignaler = null;
		stringSlotList = null;
		// Use the facade to instantiate both.
		this.instantiateSignalerWithSlotList("string", String);
		// Assert that they are both not null.
		assertTrue(voidSignaler != null);
		assertTrue(voidSlotList != null);
	}
}
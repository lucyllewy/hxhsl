package org.hsl.slotlist;
import haxe.unit.TestCase;
import org.hsl.bubbling.Bubbler;
import org.hsl.bridge.SignalerSlotListBridge;
import org.hsl.dispatching.Dispatcher;
import org.hsl.signaler.Signaler;
import org.hsl.slotlist.SlotList;
import org.hsl.Signal;

class SlotListTester extends TestCase {
	private var callCount:Int;
	private var slotList:SlotList<Void>;
	public function new():Void {
		super();
		slotList = new SlotList<Void>(new NullSignaler<Void>());
	}
	public function increaseCallCountBySignal(signal:Signal<Void>):Void {
		callCount++;
	}
	public function increaseCallCount():Void {
		callCount++;
	}
	public function testNiladicSlots():Void {
		// Reset the call count.
		callCount = 0;
		// Assert that there are no slots in the slot list.
		assertEquals(0, slotList.numberOfSlots);
		// Create one slot.
		slotList.createNiladic(increaseCallCount);
		// Assert that there are is one slot in the slot list.
		assertEquals(1, slotList.numberOfSlots);
		// Call the slots.
		slotList.callSlots(null);
		// Assert that the call count is now 1.
		assertEquals(1, callCount);
		// Create another slot.
		slotList.createNiladic(increaseCallCount);
		// Assert that there are two slots in the slot list.
		assertEquals(2, slotList.numberOfSlots);
		// Call the slots.
		slotList.callSlots(null);
		// Assert that the call count is now 3.
		assertEquals(3, callCount);
		// Assert that destroying those slots works twice, but then fails.
		assertTrue(slotList.destroyNiladic(increaseCallCount));
		assertTrue(slotList.destroyNiladic(increaseCallCount));
		assertFalse(slotList.destroyNiladic(increaseCallCount));
		// Assert that there are no slots in the slot list.
		assertEquals(0, slotList.numberOfSlots);
	}
	public function testSlots():Void {
		// Reset the call count.
		callCount = 0;
		// Assert that there are no slots in the slot list.
		assertEquals(0, slotList.numberOfSlots);
		// Create one slot.
		slotList.createRegular(increaseCallCountBySignal);
		// Assert that there are is one slot in the slot list.
		assertEquals(1, slotList.numberOfSlots);
		// Call the slots.
		slotList.callSlots(null);
		// Assert that the call count is now 1.
		assertEquals(1, callCount);
		// Create another slot.
		slotList.createRegular(increaseCallCountBySignal);
		// Assert that there are two slots in the slot list.
		assertEquals(2, slotList.numberOfSlots);
		// Call the slots.
		slotList.callSlots(null);
		// Assert that the call count is now 3.
		assertEquals(3, callCount);
		// Assert that destroying those slots works twice, but then fails.
		assertTrue(slotList.destroyRegular(increaseCallCountBySignal));
		assertTrue(slotList.destroyRegular(increaseCallCountBySignal));
		assertFalse(slotList.destroyRegular(increaseCallCountBySignal));
		// Assert that there are no slots in the slot list.
		assertEquals(0, slotList.numberOfSlots);
	}
}
class NullSignaler<D> implements ISignaler<D> {
	public var advanced(default, null):IAdvanced<D>;
	public var bubbler(default, setBubbler):IBubbler<D>;
	public var dispatcher(default, null):IDispatcher;
	public function new():Void {
		advanced = new NullAdvanced<D>();
	}
	public function dispatchSignal(?data:D):Void {
	}
	public function setBubbler(value:IBubbler<D>):IBubbler<D> {
		return null;
	}
}
class NullAdvanced<D> implements IAdvanced<D> {
	public function new():Void {
	}
	public function bubbleSignal(data:D, dispatcher:IDispatcher):Void {
	}
	public function connectWithSlotList(signalerSlotListBridge:ISignalerSlotListBridge<D>):Void {
	}
	public function disconnectFromSlotList():Void {
	}
}
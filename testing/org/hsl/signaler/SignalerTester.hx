package org.hsl.signaler;
import haxe.unit.TestCase;
import org.hsl.bridge.SignalerSlotListBridge;
import org.hsl.dispatching.Dispatcher;
import org.hsl.signaler.Signaler;
import org.hsl.Signal;
class SignalerTester extends TestCase {
	private var signaler:Signaler<TestData>;
	public function new():Void {
		super();
		signaler = new Signaler<TestData>(new NullDispatcher());
	}
	private function testDispatching():Void {
		// Create a test signaler-slotlist bridge and connect the signaler to it.
		var testSignalerSlotListBridge:TestSignalerSlotListBridge<TestData> = new TestSignalerSlotListBridge<TestData>();
		signaler.advanced.connectWithSlotList(testSignalerSlotListBridge);
		// Create some test data.
		var testData:TestData = new TestData();
		// Use the dispatchSignal method of the signaler to dispatch the test data created above.
		signaler.dispatchSignal(testData);
		// Assert that the data inside the lastReceivedSignal property of the test signaler-slot bridge equals the test data created above.
		assertEquals(testData, testSignalerSlotListBridge.lastReceivedSignal.data);
	}
}
class TestSignalerSlotListBridge<D> implements ISignalerSlotListBridge<D> {
	public var lastReceivedSignal(default, null):Signal<D>;
	public function new():Void {
	}
	public function callSlots(signal:Signal<D>):Void {
		lastReceivedSignal = signal;
	}
}
class TestData {
	public function new():Void {
	}
}
class NullDispatcher implements IDispatcher {
	public function new():Void {
	}
}
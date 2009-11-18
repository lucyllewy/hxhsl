package org.hsl.bubbling;
import haxe.unit.TestCase;
import org.hsl.bubbling.Bubbler;
import org.hsl.dispatching.Dispatcher;
import org.hsl.slotlist.SlotList;
import org.hsl.signaler.Signaler;
import org.hsl.Signal;
using org.hsl.Facade;
class BubblerTester extends TestCase, implements IDispatcher {
	private var childSignalData:TestData;
	private var childSignaler:ISignaler<TestData>;
	public var childSlotList(default, null):ISlotList<TestData>;
	private var parentSignalData:TestData;
	private var parentSignaler:ISignaler<TestData>;
	public var parentSlotList(default, null):ISlotList<TestData>;
	public function new():Void {
		super();
		this.setupSignalType("parent", TestData);
		parentSlotList.createRegular(storeParentSignal);
		this.setupSignalType("child", TestData);
		childSignaler.bubbler = new FixedBubbler<TestData>(parentSignaler);
		childSlotList.createRegular(storeChildSignal);
	}
	private function storeChildSignal(signal:Signal<TestData>):Void {
		childSignalData = signal.data;
	}
	private function storeParentSignal(signal:Signal<TestData>):Void {
		parentSignalData = signal.data;
	}
	public function testBubbling():Void {
		// Create some test data.
		var testData:TestData = new TestData();
		// Make the childSignaler dispatch the testData.
		childSignaler.dispatchSignal(testData);
		// Assert that the testData is stored in the childSignalData property.
		assertEquals(testData, childSignalData);
		// Assert that the testData is also stored in the parentSignalData property, because it bubbled to the parentSignaler.
		assertEquals(testData, parentSignalData);
	}
}
class TestData {
	public function new():Void {
	}
}
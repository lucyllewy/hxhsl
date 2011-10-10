package hsl.avm2.unittest;
import flash.display.Sprite;
import flash.events.Event;
import hsl.avm2.translating.AVM2Signaler;
import hsl.haxe.unittest.UnitTestCaseBase;
import hsl.haxe.Signal;

class StopPropagationTestCase extends UnitTestCaseBase {
	private static inline var TEST_EVENT_TYPE:String = "testEvent";
	private var child:Sprite;
	private var numberOfEventsDispatched:Int;
	private var parent:Sprite;
	public function new():Void {
		super();
	}
	private function increaseNumberOfEventsDispatched(event:Event):Void {
		numberOfEventsDispatched++;
	}
	public override function setup():Void {
		child = new Sprite();
		parent = new Sprite();
		parent.addChild(child);
	}
	private function stopPropagation(signal:Signal<String>):Void {
		signal.stopPropagation();
	}
	public function testStopPropagation():Void {
		child.addEventListener(TEST_EVENT_TYPE, increaseNumberOfEventsDispatched);
		parent.addEventListener(TEST_EVENT_TYPE, increaseNumberOfEventsDispatched);
		child.dispatchEvent(new Event(TEST_EVENT_TYPE, true));
		assertEquals(2, numberOfEventsDispatched);
		numberOfEventsDispatched = 0;
		new AVM2Signaler(child, child, TEST_EVENT_TYPE).bindAdvanced(stopPropagation);
		child.dispatchEvent(new Event(TEST_EVENT_TYPE, true));
		assertEquals(1, numberOfEventsDispatched);
	}
}
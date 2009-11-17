package org.hsl;
import haxe.unit.TestCase;
import org.hsl.dispatching.Dispatcher;
import org.hsl.Signal;

class SignalTester extends TestCase {
	public function new():Void {
		super();
	}
	public function testProperties():Void {
		// Create the two dispatchers, and some data.
		var currentDispatcher:IDispatcher = new NullDispatcher();
		var dispatcher:IDispatcher = new NullDispatcher();
		var data:String = "someData";
		// Create the signal using the objects above.
		var signal:Signal<String> = new Signal<String>(data, currentDispatcher, dispatcher);
		// Assert that all the data in the signal equals the objects above.
		assertEquals(currentDispatcher, signal.currentDispatcher);
		assertEquals(data, signal.data);
		assertEquals(dispatcher, signal.dispatcher);
	}
}
class NullDispatcher implements IDispatcher {
	public function new():Void {
	}
}
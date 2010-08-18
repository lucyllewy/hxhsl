package hsl.haxe.unittest;

class IsListenedToTestCase extends UnitTestCaseBase {
	private var dog:Dog;
	public function new():Void {
		super();
	}
	private function doNothing(value:String):Void {
	}
	public override function setup():Void {
		dog = new Dog();
	}
	public function testIsListenedTo():Void {
		assertFalse(dog.barkedSignaler.isListenedTo);
		dog.barkedSignaler.bind(doNothing);
		assertTrue(dog.barkedSignaler.isListenedTo);
		dog.barkedSignaler.bind(doNothing);
		assertTrue(dog.barkedSignaler.isListenedTo);
		dog.barkedSignaler.unbind(doNothing);
		assertTrue(dog.barkedSignaler.isListenedTo);
		dog.barkedSignaler.unbind(doNothing);
		assertFalse(dog.barkedSignaler.isListenedTo);
	}
}
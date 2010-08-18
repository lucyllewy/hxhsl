package hsl.haxe.unittest;

class IllegalDispatchTestCase extends UnitTestCaseBase {
	private var dog:Dog;
	public function new():Void {
		super();
	}
	private function dispatchIllegal():Void {
		dog.barkedSignaler.dispatch();
	}
	public override function setup():Void {
		dog = new Dog();
	}
	public function testIllegalDispatching():Void {
		assertThrows(dispatchIllegal);
	}
}
package hsl.haxe.unittest;

class IllegalDispatchTestCase extends UnitTestCaseBase {
	private var dog:Dog;
	public function new():Void {
		super();
	}
	private function dispatchIllegal():Void {
		dog.barkedSignaler.dispatch(Dog.BARK);
	}
	private function dispatchNull():Void {
		dog.customBark(null);
	}
	public override function setup():Void {
		dog = new Dog();
	}
	// In AS3 the illegal dispatching test will fail in release mode. This will produce a warning, which is just fine.
	public function testIllegalDispatching():Void {
		#if as3
		return;
		#end
		assertThrows(dispatchIllegal);
	}
	public function testNullDispatching():Void {
		assertThrows(dispatchNull);
	}
}
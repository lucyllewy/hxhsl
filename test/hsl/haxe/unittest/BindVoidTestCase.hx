package hsl.haxe.unittest;

class BindVoidTestCase extends UnitTestCaseBase {
	private var cat:Cat;
	private var dog:Dog;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		cat = new Cat();
		dog = new Dog();
	}
	public function testBindingVoid():Void {
		assertFalse(cat.isRunning);
		dog.barkedSignaler.bindVoid(cat.startRunning);
		assertFalse(cat.isRunning);
		dog.bark();
		assertTrue(cat.isRunning);
		cat.reset();
		assertFalse(cat.isRunning);
		dog.barkedSignaler.unbindVoid(cat.startRunning);
		assertFalse(cat.isRunning);
		dog.bark();
		assertFalse(cat.isRunning);
	}
}
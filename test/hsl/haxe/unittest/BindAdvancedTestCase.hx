package hsl.haxe.unittest;
import hsl.haxe.Signal;
import hsl.haxe.Subject;

class BindAdvancedTestCase extends UnitTestCaseBase {
	private var dog:Dog;
	private var verificationCompleted:Bool;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		dog = new Dog();
		verificationCompleted = false;
	}
	public function testBindingAdvanced():Void {
		dog.barkedSignaler.bindAdvanced(verifySignal);
		dog.bark();
		dog.barkedSignaler.unbindAdvanced(verifySignal);
		dog.bark();
	}
	private function verifySignal(value:Signal<String>):Void {
		assertFalse(verificationCompleted);
		assertEquals(Dog.BARK, value.data1);
		assertEquals(cast dog, value.currentTarget);
		assertEquals(cast dog, value.origin);
		verificationCompleted = true;
	}
}
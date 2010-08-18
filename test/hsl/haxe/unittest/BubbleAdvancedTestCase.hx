package hsl.haxe.unittest;
import hsl.haxe.Signal;

class BubbleAdvancedTestCase extends UnitTestCaseBase {
	private var firstDog:Dog;
	private var secondDog:Dog;
	private var verificationCompleted:Bool;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		firstDog = new Dog();
		secondDog = new Dog();
		verificationCompleted = false;
	}
	public function testBubblingAdvanced():Void {
		firstDog.barkedSignaler.addBubblingTarget(secondDog.barkedSignaler);
		secondDog.barkedSignaler.bindAdvanced(verifySignal);
		firstDog.bark();
		firstDog.barkedSignaler.removeBubblingTarget(secondDog.barkedSignaler);
		firstDog.bark();
	}
	private function verifySignal(value:Signal<String>):Void {
		assertFalse(verificationCompleted);
		assertEquals(Dog.BARK, value.data1);
		assertEquals(cast secondDog, value.currentTarget);
		assertEquals(cast firstDog, value.origin);
		verificationCompleted = true;
	}
}
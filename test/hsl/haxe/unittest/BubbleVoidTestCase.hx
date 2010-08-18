package hsl.haxe.unittest;

class BubbleVoidTestCase extends UnitTestCaseBase {
	private var cat:Cat;
	private var firstDog:Dog;
	private var secondDog:Dog;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		cat = new Cat();
		firstDog = new Dog();
		secondDog = new Dog();
	}
	public function testBubblingVoid():Void {
		assertFalse(cat.isRunning);
		firstDog.barkedSignaler.addBubblingTarget(secondDog.barkedSignaler);
		secondDog.barkedSignaler.bindVoid(cat.startRunning);
		assertFalse(cat.isRunning);
		firstDog.bark();
		assertTrue(cat.isRunning);
		cat.reset();
		assertFalse(cat.isRunning);
		firstDog.barkedSignaler.removeBubblingTarget(secondDog.barkedSignaler);
		assertFalse(cat.isRunning);
		firstDog.bark();
		assertFalse(cat.isRunning);
	}
}
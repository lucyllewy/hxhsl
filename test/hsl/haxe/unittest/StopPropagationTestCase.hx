package hsl.haxe.unittest;
import hsl.haxe.Bond;
import hsl.haxe.Signal;

class StopPropagationTestCase extends UnitTestCaseBase {
	private var firstCat:Cat;
	private var firstDog:Dog;
	private var secondCat:Cat;
	private var secondDog:Dog;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		firstCat = new Cat();
		firstDog = new Dog();
		secondCat = new Cat();
		secondDog = new Dog();
	}
	private function stopImmediatePropagation(signal:Signal<String>):Void {
		signal.stopImmediatePropagation();
	}
	private function stopPropagation(signal:Signal<String>):Void {
		signal.stopPropagation();
	}
	public function testStopPropagation():Void {
		firstDog.barkedSignaler.addBubblingTarget(secondDog.barkedSignaler);
		var stopPropagationBond:Bond = firstDog.barkedSignaler.bindAdvanced(stopPropagation);
		stopPropagationBond.halt();
		var stopImmediatePropagationBond:Bond = firstDog.barkedSignaler.bindAdvanced(stopImmediatePropagation);
		stopImmediatePropagationBond.halt();
		firstDog.barkedSignaler.bindVoid(firstCat.startRunning);
		secondDog.barkedSignaler.bindVoid(secondCat.startRunning);
		assertFalse(firstCat.isRunning);
		assertFalse(secondCat.isRunning);
		firstDog.bark();
		assertTrue(firstCat.isRunning);
		assertTrue(secondCat.isRunning);
		firstCat.reset();
		secondCat.reset();
		assertFalse(firstCat.isRunning);
		assertFalse(secondCat.isRunning);
		stopPropagationBond.resume();
		firstDog.bark();
		stopPropagationBond.halt();
		assertTrue(firstCat.isRunning);
		assertFalse(secondCat.isRunning);
		firstCat.reset();
		secondCat.reset();
		assertFalse(firstCat.isRunning);
		assertFalse(secondCat.isRunning);
		stopImmediatePropagationBond.resume();
		firstDog.bark();
		stopImmediatePropagationBond.halt();
		assertFalse(firstCat.isRunning);
		assertFalse(secondCat.isRunning);
	}
}
package hsl.haxe.unittest;
import hsl.haxe.Bond;

class BondHaltTestCase extends UnitTestCaseBase {
	private var cat:Cat;
	private var dog:Dog;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		cat = new Cat();
		dog = new Dog();
	}
	public function testBondHalting():Void {
		assertFalse(cat.isRunning);
		var bond:Bond = dog.barkedSignaler.bindVoid(cat.startRunning);
		assertFalse(cat.isRunning);
		dog.bark();
		assertTrue(cat.isRunning);
		cat.reset();
		assertFalse(cat.isRunning);
		bond.halt();
		dog.bark();
		assertFalse(cat.isRunning);
		bond.resume();
		dog.bark();
		assertTrue(cat.isRunning);
	}
}
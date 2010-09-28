package hsl.haxe.unittest;
import hsl.haxe.DirectSignaler;
import hsl.haxe.Signaler;

class NotificationTestCase extends UnitTestCaseBase {
	private var cat:Cat;
	private var dog:Dog;
	private var pack:Pack;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		cat = new Cat();
		dog = new Dog();
		pack = new Pack();
	}
	public function testBubblingVoid():Void {
		assertFalse(cat.isRunning);
		pack.addDog(dog);
		pack.soundMadeSignaler.bindVoid(cat.startRunning);
		assertFalse(cat.isRunning);
		dog.bark();
		assertTrue(cat.isRunning);
		cat.reset();
		assertFalse(cat.isRunning);
		pack.removeDog(dog);
		assertFalse(cat.isRunning);
		dog.bark();
		assertFalse(cat.isRunning);
	}
}
class Pack {
	public var soundMadeSignaler(default, null):Signaler<Void>;
	public function new():Void {
		soundMadeSignaler = new DirectSignaler(this);
	}
	public function addDog(value:Dog):Void {
		value.barkedSignaler.addNotificationTarget(soundMadeSignaler);
	}
	public function removeDog(value:Dog):Void {
		value.barkedSignaler.removeNotificationTarget(soundMadeSignaler);
	}
}

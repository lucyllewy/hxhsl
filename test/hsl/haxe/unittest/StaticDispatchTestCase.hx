package hsl.haxe.unittest;
import hsl.haxe.DirectSignaler;
import hsl.haxe.Signaler;

class StaticDispatchTestCase extends UnitTestCaseBase {
	private var cat:Cat;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		cat = new Cat();
		StaticDispatcher.initialize();
	}
	public function testStaticDispatching():Void {
		assertFalse(cat.isRunning);
		StaticDispatcher.somethingHappenedSignaler.bindVoid(cat.startRunning);
		assertFalse(cat.isRunning);
		StaticDispatcher.notifyOfHappening();
		assertTrue(cat.isRunning);
	}
}
class StaticDispatcher {
	public static var somethingHappenedSignaler(default, null):Signaler<Void>;
	public static function initialize():Void {
		somethingHappenedSignaler = new DirectSignaler(StaticDispatcher);
	}
	public static function notifyOfHappening():Void {
		somethingHappenedSignaler.dispatch();
	}
}
package hsl.haxe.unittest;
import haxe.ReadOnlyTrackable;

class ReadOnlyTrackableTestCase extends UnitTestCaseBase {
	private var batman:Batman;
	public function new():Void {
		super();
	}
	private function assertPoisonIvy(enemy:String):Void {
		assertEquals("Poison Ivy", enemy);
	}
	private function setIllegal():Void {
		batman.currentEnemy.set("Penguin");
	}
	public override function setup():Void {
		batman = new Batman();
	}
	public function testReadOnlyTrackable():Void {
		assertEquals("Joker", batman.currentEnemy.value);
		batman.currentEnemy.changedSignaler.bind(assertPoisonIvy);
		batman.focusOn("Poison Ivy");
		batman.currentEnemy.changedSignaler.unbind(assertPoisonIvy);
		assertEquals("Poison Ivy", batman.currentEnemy.value);
		// In AS3 the illegal setting test will fail in release mode.
		#if !as3
		assertThrows(setIllegal);
		#end
	}
}
class Batman {
	public var currentEnemy(default, null):ReadOnlyTrackable<String>;
	public function new():Void {
		currentEnemy = new ReadOnlyTrackable("Joker", this);
	}
	public function focusOn(enemy:String):Void {
		currentEnemy.set(enemy);
	}
}

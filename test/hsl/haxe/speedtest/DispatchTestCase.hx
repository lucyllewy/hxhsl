package hsl.haxe.speedtest;
import hsl.haxe.direct.DirectSignaler;
import hsl.haxe.Signaler;

class DispatchTestCase implements SpeedTestCase {
	public var description(default, null):String;
	public var iterations(default, null):Int;
	public var name(default, null):String;
	private var signaler:Signaler<Void>;
	public function new():Void {
		description = "signaler.dispatch() on a signaler with one of every kind of bonds";
		iterations = 100000;
		name = "dispatch test";
	}
	private function doNothing():Void {
	}
	private function doNothingWith(value:Dynamic):Void {
	}
	public function setup():Void {
		signaler = new DirectSignaler(this);
		signaler.bindVoid(doNothing);
		signaler.bind(doNothingWith);
		signaler.bindAdvanced(doNothingWith);
	}
	public function run():Void {
		signaler.dispatch();
	}
}
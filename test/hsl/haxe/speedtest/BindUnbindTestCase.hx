package hsl.haxe.speedtest;
import hsl.haxe.direct.DirectSignaler;
import hsl.haxe.Signaler;

class BindUnbindTestCase implements SpeedTestCase {
	public var description(default, null):String;
	public var iterations(default, null):Int;
	public var name(default, null):String;
	private var signaler:Signaler<Void>;
	public function new():Void {
		description = "signaler.bind([...]) and signaler.unbind([...])";
		iterations = 100000;
		name = "bind-unbind test";
	}
	private function doNothing(value:Void):Void {
	}
	public function setup():Void {
		signaler = new DirectSignaler(this);
	}
	public function run():Void {
		signaler.bind(doNothing);
		signaler.unbind(doNothing);
	}
}
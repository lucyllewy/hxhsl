package hsl.haxe.speedtest;
import hsl.haxe.direct.DirectSignaler;

class DirectSignalerInstantiationTestCase implements SpeedTestCase {
	public var description(default, null):String;
	public var iterations(default, null):Int;
	public var name(default, null):String;
	public function new():Void {
		description = "new DirectSignaler(this)";
		iterations = 100000;
		name = "Direct signaler instantiation test";
	}
	public function setup():Void {
	}
	public function run():Void {
		new DirectSignaler(this);
	}
}
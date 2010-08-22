package hsl.haxe.speedtest;

class EmptyTestCase implements SpeedTestCase {
	public var description(default, null):String;
	public var iterations(default, null):Int;
	public var name(default, null):String;
	public function new():Void {
		iterations = 10000000;
		name = "Empty test (for reference)";
	}
	public function setup():Void {
	}
	public function run():Void {
	}
}
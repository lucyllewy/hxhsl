package hsl.haxe.speedtest;

interface SpeedTestCase {
	public var description(default, null):String;
	public var iterations(default, null):Int;
	public var name(default, null):String;
	public function setup():Void;
	public function run():Void;
}
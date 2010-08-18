package hsl.haxe.unittest;

class Cat {
	public var isRunning(default, null):Bool;
	public function new():Void {
		reset();
	}
	public function reset():Void {
		isRunning = false;
	}
	public function startRunning():Void {
		isRunning = true;
	}
}
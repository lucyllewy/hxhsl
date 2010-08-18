package hsl.haxe.unittest;
import hsl.haxe.direct.DirectSignaler;
import hsl.haxe.Signaler;

class Dog {
	public static inline var BARK:String = "Woof";
	public var barkedSignaler(default, null):Signaler<String>;
	public function new():Void {
		barkedSignaler = new DirectSignaler(this);
	}
	public function bark():Void {
		barkedSignaler.dispatch(BARK);
	}
}
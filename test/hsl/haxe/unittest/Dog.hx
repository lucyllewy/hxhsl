package hsl.haxe.unittest;
import hsl.haxe.DirectSignaler;
import hsl.haxe.Signaler;

class Dog {
	public static inline var BARK:String = "Woof";
	public var barkedSignaler(default, null):Signaler<String>;
	public function new():Void {
		barkedSignaler = new DirectSignaler(this, true);
	}
	public function bark():Void {
		barkedSignaler.dispatch(BARK);
	}
	public function customBark(barkSound:String):Void {
		barkedSignaler.dispatch(barkSound);
	}
}
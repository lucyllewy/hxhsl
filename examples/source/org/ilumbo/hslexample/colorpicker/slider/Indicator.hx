package org.ilumbo.hslexample.colorpicker.slider;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;

class Indicator {
	private var _view:View;
	public var view(default, null):DisplayObject;
	public function new():Void {
		view = _view = new View();
	}
}
private class View extends Sprite {
	private static inline var HEIGHT:Float = 18;
	private static inline var WIDTH:Float = 6;
	public function new():Void {
		super();
		draw();
	}
	private inline function draw():Void {
		graphics.lineStyle(2, 0xCFCFCF, .75, true);
		graphics.drawRoundRect( -.5 * WIDTH, -.5 * HEIGHT, WIDTH, HEIGHT, 8);
		graphics.endFill();
	}
}
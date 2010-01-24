package org.ilumbo.hslexample.colorpicker.slider;
import flash.display.DisplayObject;

class EasingIndicatorMover implements IndicatorMover {
	private static inline var EASING_FACTOR:Float = 1 / 3;
	private var indicatorView:DisplayObject;
	private var targetX:Float;
	public function new(indicatorView:DisplayObject):Void {
		this.indicatorView = indicatorView;
	}
	public inline function step():Void {
		indicatorView.x += (targetX - indicatorView.x) * EASING_FACTOR;
	}
	public function moveIndicator(x:Float):Void {
		targetX = x;
	}
}
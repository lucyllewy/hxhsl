package org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing;
import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;

class HueGradientBackgroundDrawer implements BackgroundDrawer {
	public function new():Void {
	}
	public function drawBackground(target:Sprite, x:Float, y:Float, width:Float, height:Float):Void {
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(width, height, 0);
		target.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0xFFFF00, 0xFF00, 0xFFFF, 0xFF, 0xFF00FF, 0xFF0000], [1, 1, 1, 1, 1, 1, 1], [0, 0xFF * (1 / 6), 0xFF * (2 / 6), 0xFF * (3 / 6), 0xFF * (4 / 6), 0xFF * (5 / 6), 0xFF], matrix);
		target.graphics.drawRoundRect(x, y, width, height, 4);
		target.graphics.endFill();
	}
}
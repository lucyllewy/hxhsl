package org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing;
import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;

class SimpleGradientBackgroundDrawer implements BackgroundDrawer {
	private var leftColor:UInt;
	private var rightColor:UInt;
	public function new(leftColor:UInt, rightColor:UInt):Void {
		this.leftColor = leftColor;
		this.rightColor = rightColor;
	}
	public function drawBackground(target:Sprite, x:Float, y:Float, width:Float, height:Float):Void {
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(width, height, 0);
		target.graphics.beginGradientFill(GradientType.LINEAR, [leftColor, rightColor], [1, 1], [0, 0xFF], matrix);
		target.graphics.drawRoundRect(x, y, width, height, 4);
		target.graphics.endFill();
	}
}
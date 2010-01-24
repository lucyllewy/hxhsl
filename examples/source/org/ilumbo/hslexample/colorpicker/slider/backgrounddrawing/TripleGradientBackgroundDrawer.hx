package org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing;
import flash.display.GradientType;
import flash.display.Sprite;
import flash.geom.Matrix;

class TripleGradientBackgroundDrawer implements BackgroundDrawer {
	private var firstColor:UInt;
	private var secondColor:UInt;
	private var thirdColor:UInt;
	public function new(firstColor:UInt, secondColor:UInt, thirdColor:UInt):Void {
		this.firstColor = firstColor;
		this.secondColor = secondColor;
		this.thirdColor = thirdColor;
	}
	public function drawBackground(target:Sprite, x:Float, y:Float, width:Float, height:Float):Void {
		var matrix:Matrix = new Matrix();
		matrix.createGradientBox(width, height, 0);
		target.graphics.beginGradientFill(GradientType.LINEAR, [firstColor, secondColor, thirdColor], [1, 1, 1], [0, 0x7F, 0xFF], matrix);
		target.graphics.drawRoundRect(x, y, width, height, 4);
		target.graphics.endFill();
	}
}
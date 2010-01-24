package org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing;
import flash.display.Sprite;

interface BackgroundDrawer {
	public function drawBackground(target:Sprite, x:Float, y:Float, width:Float, height:Float):Void;
}
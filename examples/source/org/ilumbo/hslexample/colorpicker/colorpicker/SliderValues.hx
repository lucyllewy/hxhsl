package org.ilumbo.hslexample.colorpicker.colorpicker;

class SliderValues {
	public var firstSliderValue(default, null):Float;
	public var secondSliderValue(default, null):Float;
	public var thirdSliderValue(default, null):Float;
	public function new(firstSliderValue:Float, secondSliderValue:Float, thirdSliderValue:Float):Void {
		this.firstSliderValue = firstSliderValue;
		this.secondSliderValue = secondSliderValue;
		this.thirdSliderValue = thirdSliderValue;
	}
}
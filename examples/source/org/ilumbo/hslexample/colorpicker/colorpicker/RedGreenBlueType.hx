package org.ilumbo.hslexample.colorpicker.colorpicker;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.BackgroundDrawer;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.SimpleGradientBackgroundDrawer;

class RedGreenBlueType implements Type {
	public var firstSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public var secondSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public var thirdSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public function new():Void {
		firstSliderBackgroundDrawer = new SimpleGradientBackgroundDrawer(0x1F3F3F, 0xFF0000);
		secondSliderBackgroundDrawer = new SimpleGradientBackgroundDrawer(0x3F1F3F, 0xFF00);
		thirdSliderBackgroundDrawer = new SimpleGradientBackgroundDrawer(0x3F3F1F, 0xFF);
	}
	public function calculateColor(sliderValues:SliderValues):UInt {
		return (Math.floor(sliderValues.firstSliderValue * 0xFF) << 16) ^ (Math.floor(sliderValues.secondSliderValue * 0xFF) << 8) ^ Math.floor(sliderValues.thirdSliderValue * 0xFF);
	}
	public function calculateSliderValues(color:UInt):SliderValues {
		return new SliderValues(mask(color >> 16) / 0xFF, mask(color >> 8) / 0xFF, mask(color) / 0xFF);
	}
	private inline function mask(value:UInt):UInt {
		return value & 0xFF;
	}
}
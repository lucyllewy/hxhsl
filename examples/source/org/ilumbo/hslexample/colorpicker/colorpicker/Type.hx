package org.ilumbo.hslexample.colorpicker.colorpicker;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.BackgroundDrawer;

interface Type {
	public var firstSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public var secondSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public var thirdSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public function calculateColor(sliderValues:SliderValues):UInt;
	public function calculateSliderValues(color:UInt):SliderValues;
}
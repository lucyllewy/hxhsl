package org.ilumbo.hslexample.colorpicker.colorpicker;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import org.hsl.haxe.direct.DirectSignaler;
import org.hsl.haxe.Signaler;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.BackgroundDrawer;
import org.ilumbo.hslexample.colorpicker.slider.EasingIndicatorMover;
import org.ilumbo.hslexample.colorpicker.slider.Indicator;
import org.ilumbo.hslexample.colorpicker.slider.Slider;

class ColorPicker {
	private static inline var WIDTH:Float = 128;
	private var _view:View;
	private var calculateColor:SliderValues -> UInt;
	public var color(default, null):UInt;
	public var colorChangedSignaler(default, null):Signaler<Void>;
	private var firstSlider:Slider;
	private var indicatorMovers:List<EasingIndicatorMover>;
	private var secondSlider:Slider;
	private var thirdSlider:Slider;
	public var view(default, null):DisplayObject;
	public function new(type:Type, initialColor:UInt):Void {
		calculateColor = type.calculateColor;
		colorChangedSignaler = new DirectSignaler<Void>(this);
		indicatorMovers = new List<EasingIndicatorMover>();
		view = _view = new View();
		var initialSliderValues:SliderValues = type.calculateSliderValues(initialColor);
		firstSlider = createSlider(type.firstSliderBackgroundDrawer, initialSliderValues.firstSliderValue, 0);
		secondSlider = createSlider(type.secondSliderBackgroundDrawer, initialSliderValues.secondSliderValue, 25);
		thirdSlider = createSlider(type.thirdSliderBackgroundDrawer, initialSliderValues.thirdSliderValue, 50);
	}
	private function createSlider(backgroundDrawer:BackgroundDrawer, initialValue:Float, y:Float):Slider {
		var indicator:Indicator = new Indicator();
		var indicatorMover:EasingIndicatorMover = new EasingIndicatorMover(indicator.view);
		indicatorMovers.add(indicatorMover);
		var result:Slider = new Slider(WIDTH, initialValue, indicator, indicatorMover, backgroundDrawer);
		// When the value of the slider changes, update the color.
		result.valueChangedSignaler.addNiladicSlot(updateColor);
		result.view.y = y;
		_view.addSlider(result);
		return result;
	}
	public inline function step():Void {
		for (indicatorMover in indicatorMovers) {
			indicatorMover.step();
		}
	}
	private function updateColor():Void {
		color = calculateColor(new SliderValues(firstSlider.value, secondSlider.value, thirdSlider.value));
		// Dispatch a signal to informs whoever is listening that the color has changed.
		colorChangedSignaler.dispatch();
	}
}
private class View extends Sprite {
	public function new():Void {
		super();
		setupFilter();
	}
	public inline function addSlider(value:Slider):Void {
		addChild(value.view);
	}
	private inline function setupFilter():Void {
		var filters:Array<Dynamic> = filters;
		filters.push(new GlowFilter(0, .5, 4, 4, 2, BitmapFilterQuality.HIGH));
		this.filters = filters;
	}
}
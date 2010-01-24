/**
 * Copyright 2009, Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 *           2010, Pimm Hogeling
 * 
 * This file was based on the work of Mark de Bruijn, and was modified by Pimm Hogeling.
 */
package org.ilumbo.hslexample.colorpicker.colorpicker;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.BackgroundDrawer;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.HueGradientBackgroundDrawer;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.SimpleGradientBackgroundDrawer;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.TripleGradientBackgroundDrawer;

class HueSaturationLightnessType implements Type {
	public var firstSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public var secondSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public var thirdSliderBackgroundDrawer(default, null):BackgroundDrawer;
	public function new():Void {
		firstSliderBackgroundDrawer = new HueGradientBackgroundDrawer();
		secondSliderBackgroundDrawer = new SimpleGradientBackgroundDrawer(0x7F7F7F, 0x68E016);
		thirdSliderBackgroundDrawer = new TripleGradientBackgroundDrawer(0, 0x68E016, 0xFFFFFF);
	}
	public function calculateColor(sliderValues:SliderValues):UInt {
		var s = sliderValues.secondSliderValue;
		var l = sliderValues.thirdSliderValue;
		if (s == 0) {
			var c = Math.floor(l * 0xFF);
			return (c << 16) ^ (c << 8) ^ c;
		}
		var h = sliderValues.firstSliderValue;
		var q = if (l < 1 / 2)
				l * (1 + s)
			else
				l + s - (l * s);
		var p = 2 * l - q;
		var tr = h + 1 / 3;
		var tg = h;
		var tb = h - 1 / 3;
		
		if (tr < 0) tr += 1;
		else if (tr > 1) tr -= 1;
		if (tg < 0) tg  += 1;
		else if (tg  > 1) tg  -= 1;
		if (tb < 0) tb += 1;
		else if (tb > 1) tb -= 1;
		
		tr = if (tr < 1 / 6)
				p + ((q - p) * 6 * tr)
			else if (tr < 1 / 2)
				q
			else if (tr < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tr))
			else
				p;
		tg = if (tg < 1 / 6)
				p + ((q - p) * 6 * tg)
			else if (tg < 1 / 2)
				q
			else if (tg < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tg))
			else
				p;
		tb = if (tb < 1 / 6)
				p + ((q - p) * 6 * tb)
			else if (tb < 1 / 2)
				q
			else if (tb < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tb))
			else
				p;
		return (Math.floor(tr * 0xFF) << 16) ^ (Math.floor(tg * 0xFF) << 8) ^ Math.floor(tb * 0xFF);
	}
	public function calculateSliderValues(color:UInt):SliderValues {
		var r = mask(color >> 16) / 0xFF;
		var g = mask(color >> 8) / 0xFF;
		var b = mask(color) / 0xFF;
		var max = Math.max(r, Math.max(b, g));
		var min = Math.min(r, Math.min(g, b));
		var h = if (max == min)
				0;
			else if (max == r)
				(60 * (g - b) / (max - min) + 360) % 360;
			else if (max == g)
				60 * (b - r) / (max - min) + 120;
			else//if(max == b)
				60 * (r - g) / (max - min) + 240;
		var l = 1 / 2 * (max + min);
		var s = if (max == min)
				0;
			else if (l <= 1 / 2)
				(max - min) / (2 * l);
			else
				(max - min) / (2 - 2 * l);
		return new SliderValues(h / 360, s, l);
	}
	private inline function mask(value:UInt):UInt {
		return value & 0xFF;
	}
}
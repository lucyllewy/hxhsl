package org.grumpytoad.hslexample.mouseclick;

import js.Dom;
import js.Lib;
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.js.translation.DatalessTranslator;
import org.hsl.js.translation.JSTranslatingSignaler;
import org.hsl.js.translation.mouse.MouseClickTranslator;

class Main {
	function new()
	{
		var result = Lib.document.getElementById("result");
		var locationSignaler = new JSTranslatingSignaler<ButtonState>(result, result, MOUSEDOWN, new MouseClickTranslator());
		locationSignaler.addSlot(onClick);
	}
	function onClick(signal:Signal<ButtonState>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "mouse button pressed: " + signal.data;
	}
	static function main () {
		new Main();
	}
}




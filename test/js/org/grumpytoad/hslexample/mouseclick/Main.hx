package org.grumpytoad.hslexample.mouseclick;

import js.Dom;
import js.Lib;
import hsl.haxe.Signal;
import hsl.js.translation.DatalessTranslator;
import hsl.js.translation.JSTranslatingSignaler;
import hsl.js.translation.mouse.MouseClickTranslator;

class Main {
	function new()
	{
		var result = Lib.document.getElementById("result");
		var locationSignaler = new JSTranslatingSignaler<ButtonState>(result, result, MOUSEDOWN, new MouseClickTranslator());
		locationSignaler.bindAdvanced(onClick);
	}
	function onClick(signal:Signal<ButtonState>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "mouse button pressed: " + signal.data1;
	}
	static function main () {
		new Main();
	}
}




package org.grumpytoad.hslexample.mouseclick;

import hsl.haxe.data.mouse.MouseCondition;
import js.Dom;
import js.Lib;
import hsl.haxe.Signal;
using hsl.js.plugins.MouseShortcuts;

class Main {
	function new()
	{
		var result = Lib.document.getElementById("result");
		result.getPressedSignaler().bindAdvanced(onClick);
	}
	function onClick(signal:Signal<MouseCondition>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "mouse button pressed: " + signal.data.button;
	}
	static function main () {
		new Main();
	}
}




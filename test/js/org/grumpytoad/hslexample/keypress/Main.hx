package org.grumpytoad.hslexample.keypress;

import js.Dom;
import js.Lib;
import hsl.haxe.Signal;
using hsl.js.plugins.KeyboardShortcuts;

class Main {
	function new()
	{
		Lib.document.getKeyPressedSignaler().bindAdvanced(onKey);
	}
	function onKey(signal:Signal<Int>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "key pressed is: " + String.fromCharCode( signal.data );
	}
	static function main () {
		new Main();
	}
}



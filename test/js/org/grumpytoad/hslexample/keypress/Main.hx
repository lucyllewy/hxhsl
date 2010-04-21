package org.grumpytoad.hslexample.keypress;

import js.Dom;
import js.Lib;
import hsl.haxe.Signal;
import hsl.js.translation.DatalessTranslator;
import hsl.js.translation.JSTranslatingSignaler;
import hsl.js.translation.keyboard.KeyCodeTranslator;

class Main {
	function new()
	{
		var locationSignaler = new JSTranslatingSignaler<Int>(Lib.document, Lib.document, KEYUP, new KeyCodeTranslator());
		locationSignaler.bindAdvanced(onKey);
	}
	function onKey(signal:Signal<Int>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "key pressed is: " + String.fromCharCode( signal.data1 );
	}
	static function main () {
		new Main();
	}
}



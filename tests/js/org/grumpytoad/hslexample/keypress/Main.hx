package org.grumpytoad.hslexample.keypress;

import js.Dom;
import js.Lib;
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.js.translation.DatalessTranslator;
import org.hsl.js.translation.JSTranslatingSignaler;
import org.hsl.js.translation.keyboard.KeyCodeTranslator;

class Main {
	function new()
	{
		var locationSignaler = new JSTranslatingSignaler<Int>(Lib.document, Lib.document, KEYUP, new KeyCodeTranslator());
		locationSignaler.addSlot(onKey);
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



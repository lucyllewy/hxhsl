package org.grumpytoad.hslexample.mousecondition;

import js.Dom;
import js.Lib;
import hsl.haxe.Signal;
import hsl.js.translation.DatalessTranslator;
import hsl.js.translation.JSTranslatingSignaler;
import hsl.js.translation.mouse.MouseCondition;
import hsl.js.translation.mouse.MouseConditionTranslator;

class Main {
	function new()
	{
		var locationSignaler = new JSTranslatingSignaler<MouseCondition>(Lib.document, Lib.document, MOUSEMOVE, new MouseConditionTranslator());
		locationSignaler.bindAdvanced(onMouseMove);
	}
	function onMouseMove(signal:Signal<MouseCondition>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "mouse location is: " + signal.data1.location.x + ", " + signal.data1.location.y + "<br />" +
			"alt: " + signal.data1.modifierKeysState.altKeyDown + ", ctrl: " + signal.data1.modifierKeysState.controlKeyDown +
			", shift: " + signal.data1.modifierKeysState.shiftKeyDown;
	}
	static function main () {
		new Main();
	}
}




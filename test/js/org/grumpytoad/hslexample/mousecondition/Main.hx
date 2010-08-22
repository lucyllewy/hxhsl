package org.grumpytoad.hslexample.mousecondition;

import hsl.js.translation.mouse.MouseConditionTranslator;
import js.Lib;
import hsl.haxe.Signal;
import hsl.js.data.mouse.MouseCondition;
import hsl.js.translating.JSSignaler;

class Main {
	function new()
	{
		new JSSignaler(Lib.document, Lib.document, MOUSEMOVE, new MouseConditionTranslator()).bindAdvanced(onMouseMove);
	}
	function onMouseMove(signal:Signal<MouseCondition>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "mouse location is: " + signal.data.location.globalLocation.x + ", " + signal.data.location.globalLocation.y + "<br />" +
			"alt: " + signal.data.modifierKeysState.altKeyDown + ", ctrl: " + signal.data.modifierKeysState.controlKeyDown +
			", shift: " + signal.data.modifierKeysState.shiftKeyDown;
	}
	static function main () {
		new Main();
	}
}




package org.grumpytoad.hslexample.mousecondition;

import js.Dom;
import js.Lib;
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.js.translation.DatalessTranslator;
import org.hsl.js.translation.JSTranslatingSignaler;
import org.hsl.js.translation.mouse.MouseCondition;
import org.hsl.js.translation.mouse.MouseConditionTranslator;

class Main {
	function new()
	{
		var locationSignaler = new JSTranslatingSignaler<MouseCondition>(Lib.document, Lib.document, MOUSEMOVE, new MouseConditionTranslator());
		locationSignaler.addSlot(onMouseMove);
	}
	function onMouseMove(signal:Signal<MouseCondition>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "mouse location is: " + signal.data.location.x + ", " + signal.data.location.y + "<br />" +
			"alt: " + signal.data.modifierKeysState.altKeyDown + ", ctrl: " + signal.data.modifierKeysState.controlKeyDown +
			", shift: " + signal.data.modifierKeysState.shiftKeyDown;
	}
	static function main () {
		new Main();
	}
}




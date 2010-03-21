package org.grumpytoad.hslexample.location;

import js.Dom;
import js.Lib;
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.js.translation.DatalessTranslator;
import org.hsl.js.translation.JSTranslatingSignaler;
import org.hsl.js.translation.mouse.LocalMouseLocation;
import org.hsl.js.translation.mouse.MouseLocationTranslator;

class Main {
	function new()
	{
		var sniff :HtmlDom = Lib.document.getElementById("sniff");
		var locationSignaler = new JSTranslatingSignaler<LocalMouseLocation>(sniff, sniff, MOUSEMOVE, new MouseLocationTranslator());
		locationSignaler.addSlot(onMove);
	}
	function onMove(signal:Signal<LocalMouseLocation>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "x: " + signal.data.x + ", y: " + signal.data.y
			+ ", globalX: " + signal.data.globalLocation.x + ", globalY: " + signal.data.globalLocation.y;
	}
	static function main () {
		new Main();
	}
}


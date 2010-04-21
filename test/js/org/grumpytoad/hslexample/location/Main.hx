package org.grumpytoad.hslexample.location;

import js.Dom;
import js.Lib;
import hsl.haxe.Signal;
import hsl.js.translation.DatalessTranslator;
import hsl.js.translation.JSTranslatingSignaler;
import hsl.js.translation.mouse.LocalMouseLocation;
import hsl.js.translation.mouse.MouseLocationTranslator;

class Main {
	function new()
	{
		var sniff :HtmlDom = Lib.document.getElementById("sniff");
		var locationSignaler = new JSTranslatingSignaler<LocalMouseLocation>(sniff, sniff, MOUSEMOVE, new MouseLocationTranslator());
		locationSignaler.bindAdvanced(onMove);
	}
	function onMove(signal:Signal<LocalMouseLocation>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "x: " + signal.data1.x + ", y: " + signal.data1.y
			+ ", globalX: " + signal.data1.globalLocation.x + ", globalY: " + signal.data1.globalLocation.y;
	}
	static function main () {
		new Main();
	}
}


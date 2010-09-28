package org.grumpytoad.hslexample.location;

import hsl.haxe.data.mouse.MouseLocation;
import js.Dom;
import js.Lib;
import hsl.haxe.Signal;
using hsl.js.plugins.MouseShortcuts;

class Main {
	function new()
	{
		var sniff :HtmlDom = Lib.document.getElementById("sniff");
		sniff.getMouseMovedSignaler().bindAdvanced(onMove);
	}
	function onMove(signal:Signal<MouseLocation>)
	{
		var result = Lib.document.getElementById("result");
		result.innerHTML = "x: " + signal.data.x + ", y: " + signal.data.y
			+ ", globalX: " + signal.data.globalLocation.x + ", globalY: " + signal.data.globalLocation.y;
	}
	static function main () {
		new Main();
	}
}


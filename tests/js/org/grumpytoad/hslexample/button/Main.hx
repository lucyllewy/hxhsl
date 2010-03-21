package org.grumpytoad.hslexample.button;

import js.Dom;
import js.Lib;
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.js.translation.DatalessTranslator;
import org.hsl.js.translation.JSTranslatingSignaler;
import org.hsl.js.translation.mouse.DeltaTranslator;

class Main {
	function new()
	{
#if debug
		var tag : HtmlDom = Lib.document.createElement( "script" );
		tag.setAttribute( 'type', 'text/javascript' );
		tag.setAttribute( 'src', './firebug-lite-compressed.js' );

		Lib.document.body.appendChild( tag );

		haxe.Firebug.redirectTraces();
		haxe.Log.trace = log;
#end
		var button = Lib.document.getElementById('button');
		var window : Dynamic = Lib.window;
		for ( id in 0...3 )
		{
			var button = Lib.document.getElementById("button" + (id + 1));
			var signaler = new JSTranslatingSignaler<Int>(button, button, MOUSEWHEEL, new DeltaTranslator());
			signaler.addSlot(modifyColor);
		}

	}
	
	function modifyColor(signal:Signal<Int>)
	{
		var button : Dynamic = signal.initialSubject;
		var data = signal.data;
		var color = button.style.backgroundColor;
		var combine = Lib.document.getElementById('combine');

		var yield = function (pos:Int, v:Int)
		{
			if ( v != 0 )
				v = (data>0)? (v < 254) ? v + data : v : (v + data > 1) ? v + data : v;
			return v;
		}
		button.style.backgroundColor = loopColors( color, yield );
		combine.style.backgroundColor = combineColors();
	}
	function combineColors()
	{
		var r : Int = 0;
		var g : Int = 0;
		var b : Int = 0;
		for ( id in 0...3 )
		{
			var button = Lib.document.getElementById("button" + (id + 1));
			var color = button.style.backgroundColor;
			var yield = function (pos:Int, v:Int)
			{
				switch (pos)
				{
					case 0: r += v;
					case 1: g += v;
					case 2: b += v;
				}
				return v;
			}
			loopColors( color, yield );
		}
		return 'rgb(' + r + ', ' + g + ', ' + b + ')';
		
	}
	function loopColors( str:String, cb: Int -> Int -> Int )
	{
		var re = ~/rgb\(([0-9]*), ?([0-9]*), ?([0-9]*)\)/;
		var hex = ~/#([0-9a-zA-Z][0-9a-zA-Z])([0-9a-zA-Z][0-9a-zA-Z])([0-9a-zA-Z][0-9a-zA-Z])/;
		if ( re.match(str) )
		{
			var str = 'rgb(';
			for ( pos in 1...4 )
			{
				var v = Std.parseInt(re.matched(pos));
				v = cb(pos-1,v);
				str += v;
				if ( pos < 3 ) str += ', ';
			}
			str = str + ')';
			return str;
		} else if ( hex.match(str) ) {
			var str = '#';
			for ( pos in 1...4 )
			{
				var v : Int = untyped ("0x" + hex.matched(pos)) & 0xFF;
				v = cb(pos-1,v);
				str += StringTools.hex(v,2);
			}
			return str;
		} else {
			throw "Cannot parse color '" + str + "'.";
		}
	}
	static function main () {
		new Main();
	}
	public static function log ( v:Dynamic, ?pos : haxe.PosInfos ):Void {
		var console = Reflect.field( js.Lib.window, "console" );

		if ( console != null )
		console.log( pos.fileName +":"+ pos.className +":"+ pos.methodName +":"+ pos.lineNumber, v );
	}
}

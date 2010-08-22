package org.grumpytoad.hslexample.progress;

import hsl.haxe.data.progress.LoadProgress;
import js.Dom;
import js.Lib;
import js.XMLHttpRequest;
import hsl.haxe.Signal;
import hsl.js.translating.JSSignaler;
import hsl.js.translation.DatalessTranslator;
import hsl.js.translation.progress.LoadProgressTranslator;
import hsl.js.translation.error.ErrorMessage;
import hsl.js.translation.error.ErrorMessageTranslator;

class Main {
	var xmlHttpRequest:js.XMLHttpRequest;
	var doError:Bool;
	function new()
	{
		var url : String = null;
		if ( ~/doerror=true/.match(untyped Lib.document.location.href ) )
		{
			url = './ulysses2.txt';
			doError = true;
		} else {
			url = './ulysses.txt';
			doError = false;
		}

		xmlHttpRequest = new js.XMLHttpRequest(); 

		var progressSignaler = new JSSignaler<LoadProgress>(xmlHttpRequest, xmlHttpRequest, PROGRESS, new LoadProgressTranslator());
		progressSignaler.bindAdvanced(modifyProgress);
		var completeSignaler = new JSSignaler<Void>(xmlHttpRequest, xmlHttpRequest, LOAD, new DatalessTranslator<Void>());
		completeSignaler.bindAdvanced(complete);
		var errorSignaler = new JSSignaler<String>(xmlHttpRequest, xmlHttpRequest, ERROR, new ErrorMessageTranslator());
		errorSignaler.bindAdvanced(error);

		xmlHttpRequest.open("GET",url,true);
		xmlHttpRequest.send(null);

		var result = Lib.document.getElementById('result');

		// for selenium
		Reflect.setField( Lib.window, 'xmlHttpRequest', xmlHttpRequest );
	}

	function modifyProgress(signal:Signal<LoadProgress>)
	{

		var tag = Lib.document.createElement("div");
		tag.style.width = ( signal.data1.progress * 100 ) + "%";
		tag.style.height = "100%";
		tag.style.backgroundColor = "#000";
		var bar = Lib.document.getElementById("bar");
		if ( bar.firstChild != null )
			bar.removeChild( bar.firstChild );
		bar.appendChild( tag );
	}

	function complete(signal:Signal<Void>)
	{
		untyped console.log( signal.currentTarget );
		if ( doError )
			return;

		var tag = Lib.document.createElement("div");
		tag.style.width = "100%";
		tag.style.height = "100%";
		tag.style.backgroundColor = "#000";
		var bar = Lib.document.getElementById("bar");
		if ( bar.firstChild != null )
			bar.removeChild( bar.firstChild );
		bar.appendChild( tag );
		var result = Lib.document.getElementById('result');
		result.innerHTML = cast( signal.currentTarget, XMLHttpRequest).responseText;
	}

	function error( signal:Signal<String> )
	{
		var result = Lib.document.getElementById('result');
		result.innerHTML = "Error message '" + signal.data1 + "'.";
	}

	static function main () {
		new Main();
	}
}


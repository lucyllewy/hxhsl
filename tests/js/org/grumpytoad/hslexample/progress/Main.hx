package org.grumpytoad.hslexample.progress;

import js.Dom;
import js.Lib;
import js.XMLHttpRequest;
import org.hsl.haxe.Signal;
import org.hsl.haxe.Slot;
import org.hsl.js.translation.DatalessTranslator;
import org.hsl.js.translation.JSTranslatingSignaler;
import org.hsl.js.translation.progress.LoadProgress;
import org.hsl.js.translation.progress.LoadProgressTranslator;
import org.hsl.js.translation.error.ErrorMessage;
import org.hsl.js.translation.error.ErrorMessageTranslator;

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

		var progressSignaler = new JSTranslatingSignaler<LoadProgress>(xmlHttpRequest, xmlHttpRequest, PROGRESS, new LoadProgressTranslator());
		progressSignaler.addSlot(modifyProgress);
		var completeSignaler = new JSTranslatingSignaler<Void>(xmlHttpRequest, xmlHttpRequest, LOAD, new DatalessTranslator<Void>());
		completeSignaler.addSlot(complete);
		var errorSignaler = new JSTranslatingSignaler<ErrorMessage>(xmlHttpRequest, xmlHttpRequest, ERROR, new ErrorMessageTranslator());
		errorSignaler.addSlot(error);

		xmlHttpRequest.open("GET",url,true);
		xmlHttpRequest.send(null);

		var result = Lib.document.getElementById('result');

		// for selenium
		Reflect.setField( Lib.window, 'xmlHttpRequest', xmlHttpRequest );
	}

	function modifyProgress(signal:Signal<LoadProgress>)
	{

		var tag = Lib.document.createElement("div");
		tag.style.width = ( signal.data.progress * 100 ) + "%";
		tag.style.height = "100%";
		tag.style.backgroundColor = "#000";
		var bar = Lib.document.getElementById("bar");
		if ( bar.firstChild != null )
			bar.removeChild( bar.firstChild );
		bar.appendChild( tag );
	}

	function complete(signal:Signal<Void>)
	{
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
		result.innerHTML = cast( signal.initialSubject, XMLHttpRequest).responseText;
	}

	function error( signal:Signal<ErrorMessage> )
	{
		var result = Lib.document.getElementById('result');
		result.innerHTML = "Error code " + signal.data.statusCode + " with message " + signal.data.text;
	}

	static function main () {
		new Main();
	}
}


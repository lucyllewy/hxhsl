/**
 * Copyright (c) 2009-2010, The HSL Contributors. Most notable contributors, in order of appearance: Pimm Hogeling, Edo Rivai,
 * Owen Durni, Niel Drummond.
 *
 * This file is part of HSL. HSL, pronounced "hustle", stands for haXe Signaling Library.
 *
 * HSL is free software. Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *
 *   * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
 *     disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HSL CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE HSL
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * End of conditions.
 * 
 * The license of HSL might change in the near future, most likely to match the license of the haXe core libraries.
 */
package org.hsl.js.translation;

import js.Dom;
import js.Lib;
import haxe.PosInfos;
import org.hsl.haxe.Subject;
import org.hsl.haxe.translation.TranslatingSignaler;
import org.hsl.haxe.translation.Translator;

/** 
 * Javascript Event types supported by HSL
 */
enum JSEventType {
	ERROR;
	PROGRESS;
	LOAD;
	UNLOAD;
	ABORT;
	CLICK;
	SELECT;
	CHANGE;
	SUBMIT;
	RESET;
	FOCUS;
	BLUR;
	RESIZE;
	SCROLL;
	MOUSEUP;
	MOUSEDOWN;
	MOUSEMOVE;
	MOUSEOVER;
	MOUSEOUT;
	MOUSEWHEEL;
	KEYUP;
	KEYDOWN;
}

/**
 * Internal reference for mapping HSL Event types to native browser event type strings.
 */
typedef JSNativeType = { html4: String, dom2: String }

/**
 * The JS translating signaler translates JS specific events, and re-dispatches them as HSL signals.
 */
class JSTranslatingSignaler<D> extends TranslatingSignaler<D> {
	private var nativeDispatcher:HtmlDom;
	private var nativeEventType:JSNativeType;

	public function new(subject:Subject, nativeDispatcher:Dynamic, jsEventType:JSEventType, ?translator:Translator<D>, ?rejectNullData:Null<Bool>):Void {
		if (translator == null) {
			translator = new DatalessTranslator<D>();
		}

		super(subject, translator, rejectNullData);
		this.nativeDispatcher = nativeDispatcher;

		this.nativeEventType = resolveNativeType(jsEventType);

		untyped {
			if ( nativeDispatcher.addEventListener != null )
				nativeDispatcher.addEventListener( nativeEventType.dom2, dispatchNative, false );
			else 
				try
				{
					if ( nativeDispatcher.attachEvent == null )
						Reflect.setField( nativeDispatcher, nativeEventType.html4, dispatchNative );
					else
						nativeDispatcher.attachEvent( nativeEventType.html4, dispatchNative );
				} catch (e:Dynamic) {
				}
		}
	}

	/** 
	 * Resolves string names from the javascript enum JSEventType
	 * supported by HSL, and deals with browser implementations for a
	 * uniform HSL event behaviour.
	 */
	function resolveNativeType( type:JSEventType ):JSNativeType {
		switch (type) {
			case MOUSEWHEEL: 
				var useDOMMouseScroll = false;
				untyped
				{
					if( document.implementation.hasFeature('MouseEvents','2.0') )
					{
						try
						{
							var handle = null;
							handle = document.body.addEventListener( "DOMMouseScroll", 
									function () { 
										useDOMMouseScroll = true; 
										document.removeEventListener("DOMMouseScroll", handle); 
									}, 
								false );
							var evt = document.createEvent("MouseScrollEvents");
							evt.initMouseEvent("DOMMouseScroll", true, true, window,
								    0, 0, 0, 0, 0, false, false, false, false, 0, null);
							document.body.dispatchEvent(evt);
						} catch (e:Dynamic) {}
					}
				}
				return (!useDOMMouseScroll) ? { html4:"onmousewheel", dom2:"mousewheel" } : { html4:"onmousewheel", dom2:"DOMMouseScroll" };
			case CLICK: 
				    disableContextMenu();
				    return { html4:"onclick", dom2:"click" };
			case MOUSEUP: 
				     disableContextMenu();
				     return { html4:"onmouseup", dom2:"mouseup" };
			case MOUSEDOWN: 
				     disableContextMenu();
				     return { html4:"onmousedown", dom2:"mousedown" };
			default:
				    var name = Type.enumConstructor(type).toLowerCase();
				    return { html4:"on" + name, dom2:name };
		}
	}

	/** 
	 * If set through the conditional compilation command
	 * HSL_DISABLE_CONTEXT_MENU, this will disable the right-mouse context
	 * menu, so that right mouse clicks can also be captured. Note: this
	 * does not normally work on opera without browser configuration.
	 */
	function disableContextMenu()
	{
		#if HSL_DISABLE_CONTEXT_MENU
		untyped nativeDispatcher.oncontextmenu = function () { return false; }
		return true;
		#end
		return false;
	}

	public override function stop(?positionInformation:PosInfos):Void {
		super.stop(positionInformation);
		untyped {
			if ( nativeDispatcher.removeEventListener != null )
				nativeDispatcher.removeEventListener(nativeEventType, dispatchNative);
			else
				try
				{
					if ( nativeDispatcher.detachEvent == null )
						Reflect.deleteField( nativeDispatcher, nativeEventType.html4 );
					else
						nativeDispatcher.detachEvent( nativeEventType.html4, dispatchNative );
				} catch (e:Dynamic) {
				}
		}
	}

	/**
	 * This is only useful if the server responds with
	 * a specially crafted header - see
	 * http://msdn.microsoft.com/en-us/library/cc288060(VS.85).aspx
	 * for details.
	 */
	#if HSL_ENABLE_XDOMAINREQUEST
	static function __init__() {

		// support new IE 8 features
		untyped
		{
			if ( window.XDomainRequest )
			{
				var ieOrigXMLHttpRequest = js["XMLHttpRequest"];
				try
				{
					js["XMLHttpRequest"] = __js__("new XDomainRequest()");
				} catch (e:Dynamic) {
					js["XMLHttpRequest"] = ieOrigXMLHttpRequest;
				}
			}

		}
	}
	#end
}

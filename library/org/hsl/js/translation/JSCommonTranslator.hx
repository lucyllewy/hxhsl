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
import org.hsl.haxe.translation.NativeEvent;
import org.hsl.js.translation.mouse.LocalMouseLocation;
import org.hsl.js.translation.mouse.MouseLocation;

typedef Event = { > js.Event, srcElement:HtmlDom, pageX:Int, pageY:Int /* IE compat */, offsetX:Int, offsetY:Int /* missing properties */  }

/** 
 * Provides common cross-browser functions for retrieving properties of a
 * nativeEvent.
 */
class JSCommonTranslator
{
	/** 
	 * Returns the event released through the dispatched native event. 
	 */
	inline function getEvent( nativeEvent:NativeEvent )
	{
		if (nativeEvent==null) 
			nativeEvent = untyped window.event;
		return nativeEvent;
	}

	/** 
	 * Returns the target of a DOM Event
	 */
	function targetFromDOMEvent( event:js.Event )
	{
		var ieEvent :Event = cast event;
		var target : HtmlDom = null;

		if (ieEvent.target != null)
			target = ieEvent.target
		else if (ieEvent.srcElement != null)
			target = ieEvent.srcElement;

		if (target.nodeType == 3) target = target.parentNode;

		return target;
	}

	/** 
	 * Returns a LocalMouseLocation instance populated with local and
	 * global coordinates.
	 */
	function localMouseLocationFromDOMEvent( event:js.Event, target:HtmlDom )
	{
		var ieEvent :Event = cast event;

		var posx = 0;
		var posy = 0;
		if ( ieEvent.pageX != null || ieEvent.pageY != null ) {
			posx = ieEvent.pageX;
			posy = ieEvent.pageY;
		} else if ( ieEvent.clientX != null || ieEvent.clientY != null ) {
			posx = ieEvent.clientX + Lib.document.body.scrollLeft;
			posy = ieEvent.clientY + Lib.document.body.scrollTop;
		}

		var localx = 0;
		var localy = 0;
		if ( ieEvent.offsetX != null || ieEvent.offsetY != null ) {
			localx = ieEvent.offsetX;
			localy = ieEvent.offsetY;
		} else if ( Reflect.field( ieEvent, "layerX" ) != null || Reflect.field( ieEvent, "layerY" ) != null )  {
			localx = Reflect.field( ieEvent, "layerX" );
			localy = Reflect.field( ieEvent, "layerY" );
		}

		return new LocalMouseLocation(localx, localy, target, new MouseLocation(posx, posy));
	}
}

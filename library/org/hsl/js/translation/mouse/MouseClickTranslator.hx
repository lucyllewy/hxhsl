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
package org.hsl.js.translation.mouse;

import js.Lib;
import org.hsl.haxe.Subject;
import org.hsl.haxe.translation.Translation;
import org.hsl.haxe.translation.Translator;
import org.hsl.haxe.translation.NativeEvent;
import org.hsl.js.translation.JSCommonTranslator;

enum ButtonState {
	NONE;
	LEFT;
	MIDDLE;
	RIGHT;
}

/**
 * A translator that translates mouse events to modifier keys states. The modifier keys states are the states of the
 * modifier keys (the Control, Alt and Shift keys) at the moment the mouse events were dispatched.
 */
class MouseClickTranslator extends JSCommonTranslator, implements Translator<ButtonState> {
	/**
	 * Creates a new modifier keys state translator.
	 */
	public function new():Void {
	}
	public function translate(nativeEvent:NativeEvent):Translation<ButtonState> {
		var mouseEvent:Dynamic = getEvent(nativeEvent);
		var target:Subject = targetFromDOMEvent(nativeEvent);

		// note: w3c standard is not used here
		var state : ButtonState = 
			if (mouseEvent.which == null)
				switch (mouseEvent.button) {
					case 0: NONE;
					case 1: LEFT; 
					case 2: RIGHT;
					case 4: MIDDLE;
				}
			else
				switch (mouseEvent.which) {
					case 1: LEFT;
					case 2: MIDDLE; 
					case 3: RIGHT;
				}

		return new Translation<ButtonState>(state, target);
	}
	#if debug
	private function toString():String {
		return "[Translator]";
	}
	#end

}




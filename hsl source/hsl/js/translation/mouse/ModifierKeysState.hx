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
package hsl.js.translation.mouse;

/**
 * The state of the modifier keys (the Control, Alt and Shift keys.)
 */
class ModifierKeysState {
	/**
	 * Indicates whether the alt key is down (true) or not (false);
	 */
	public var altKeyDown(default, null):Bool;
	/**
	 * Indicates whether the control key is down (true) or not (false);
	 */
	public var controlKeyDown(default, null):Bool;
	/**
	 * Indicates whether the shift key is down (true) or not (false);
	 */
	public var shiftKeyDown(default, null):Bool;
	/**
	 * Creates a new modifier keys state.
	 */
	public function new(altKeyDown:Bool, controlKeyDown:Bool, shiftKeyDown:Bool):Void {
		this.altKeyDown = altKeyDown;
		this.controlKeyDown = controlKeyDown;
		this.shiftKeyDown = shiftKeyDown;
	}
	#if debug
	private function toString():String {
		return "[ModifierKeysState altKeyDown=" + altKeyDown + " controlKeyDown=" + controlKeyDown + " shiftKeyDown=" + shiftKeyDown + "]";
	}
	#end
}

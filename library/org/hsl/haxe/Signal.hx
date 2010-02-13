/**
 * Copyright (c) 2009-2010, The HSL Contributors. Most notable contributors, in order of appearance: Pimm Hogeling, Edo Rivai,
 * Owen Durni.
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
package org.hsl.haxe;

/**
 * Signals are dispatched by subjects.
 */
class Signal<D> {
	/**
	 * Indicates whether the bubbling has been stopped by this signal (true) or not (false). Bubbling can be stopped by calling
	 * the stopBubbling method.
	 */
	public var bubblingStopped(default, null):Bool;
	/**
	 * The slot that is currently processing the signal.
	 */
	public var currentSlot(default, null):Slot<D>;
	/**
	 * The subject that is currently dispatching this signal. This subject might be the initial subject for this signal, but
	 * could also be dispatching this signal in result of bubbling. For instance, if a user clicks on a button that is inside a
	 * menu, and signals bubble from that button to that menu, the current subject will be the button at some point and the menu
	 * at another. The initial subject will constantly be the button.
	 */
	public var currentSubject(default, null):Subject;
	/**
	 * The data in this signal.
	 */
	public var data(default, null):D;
	/**
	 * The subject that initially dispatched this signal. For instance, if a user clicks on a button that is inside a mune, and
	 * signals bubble from that button to that menu, the current subject will be the button at some point and the menu at
	 * another. The initial subject will constantly be the button.
	 */
	public var initialSubject(default, null):Subject;
	/**
	 * Indicates whether the propagation has been stopped by this signal (true) or not (false). Propagation can be stopped by
	 * calling the stopPropagation method.
	 */
	public var propagationStopped(default, null):Bool;
	/**
	 * Creates a new signal.
	 */
	public function new(data:D, currentSlot:Slot<D>, currentSubject:Subject, initialSubject:Subject):Void {
		this.data = data;
		this.currentSubject = currentSubject;
		this.currentSlot = currentSlot;
		this.initialSubject = initialSubject;
		// Set bubblingStopped and propagationStopped to false, unless the target is flash9, as in that case the default value
		// is false anyway.
		#if !flash9
		bubblingStopped = false;
		propagationStopped = false;
		#end
	}
	/**
	 * Stops the bubbling of the signal. The subject currently dispatching this signal will not bubble it to its bubbling
	 * targets. Calling this method does not prevent other slots in the same subject from being called: see the stopPropagation
	 * for that functionality.
	 */
	public inline function stopBubbling():Void {
		bubblingStopped = true;
	}
	/**
	 * Stops the propagation of the signal. The subject currently dispatching this signal will not call any slots after the
	 * current one. Note that this method is slightly different from the stopPropagation method in DOM events: this method
	 * prevents any slots from being called after this one, while the stopPropagation method in DOM events only prevents
	 * the signal from bubbling. See the stopBubbling method for that functionality.
	 */
	public inline function stopPropagation():Void {
		propagationStopped = true;
	}
	#if debug
	private function toString():String {
		return "[Signal data=" + data + " currentSubject=" + currentSubject + " initialSubject=" + initialSubject + "]";
	}
	#end
}
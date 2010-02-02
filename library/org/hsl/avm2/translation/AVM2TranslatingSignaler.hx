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
package org.hsl.avm2.translation;
import flash.events.EventDispatcher;
import haxe.PosInfos;
import org.hsl.haxe.Subject;
import org.hsl.haxe.translation.TranslatingSignaler;
import org.hsl.haxe.translation.Translator;

/**
 * The AVM2 translating signaler translates AVM2 specific events, and re-dispatches them as HSL signals.
 */
class AVM2TranslatingSignaler<D> extends TranslatingSignaler<D> {
	private var nativeDispatcher:EventDispatcher;
	private var nativeEventType:String;
	/**
	 * Creates a new AVM2 translating signaler. The passed subject will be considered the subject that owns the signaler, and
	 * will be allowed to call the dispatch method of the signaler. The passed translator will be used to translate events. If
	 * the rejectNullData flag is set, a non-null accepting verifier will be used to verify data passed to the dispatch method of
	 * the signaler, and data inside translations returned by the translators. If the flag is not set, an all accepting verifier
	 * will be used.
	 * 
	 * The signaler will add a listener to the passed native dispatcher, using the passed native event type, in order to
	 * re-dispatch events dispatched by that native dispatcher as HSL signals.
	 */
	public function new(subject:Subject, nativeDispatcher:EventDispatcher, nativeEventType:String, ?translator:Translator<D>, ?rejectNullData:Null<Bool>):Void {
		// If the passed translator is null, use a dataless translator.
		if (translator == null) {
			translator = new DatalessTranslator<D>();
		}
		super(subject, translator, rejectNullData);
		this.nativeDispatcher = nativeDispatcher;
		this.nativeEventType = nativeEventType;
		// Add a listener to the passed native dispatcher.
		nativeDispatcher.addEventListener(nativeEventType, dispatchNative);
	}
	public override function stop(?positionInformation:PosInfos):Void {
		super.stop(positionInformation);
		nativeDispatcher.removeEventListener(nativeEventType, dispatchNative);
	}
}
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
package org.hsl.haxe.translation;
import haxe.PosInfos;
import org.hsl.haxe.direct.DirectSignaler;
import org.hsl.haxe.Subject;

/**
 * The translating signaler translates native events/signals, and re-dispatches them as HSL signals. This class should be
 * extended to add bridge from a native event/signal system.
 */
class TranslatingSignaler<D> extends DirectSignaler<D> {
	private var translator:Translator<D>;
	/**
	 * Creates a new translating signaler. The passed subject will be considered the subject that owns the signaler, and will be
	 * allowed to call the dispatch method of the signaler. The passed translator will be used to translate native events/signals
	 * passed to the dispatchNative method. If the rejectNullData flag is set, a non-null accepting verifier will be used to
	 * verify data passed to the dispatch method of the signaler, and data inside translations returned by the translators. If
	 * the flag is not set, an all accepting verifier will be used.
	 */
	public function new(subject:Subject, translator:Translator<D>, ?rejectNullData:Null<Bool>):Void {
		super(subject, rejectNullData);
		// If the passed translater is null, throw an exception. Having null for a translator might produce null object reference
		// errors later on: when the signaler tries to translate native events/signals.
		if (translator == null) {
			// TODO: throw a more exception instead of this lame one.
			throw "The translator argument must be non-null.";
		}
		this.translator = translator;
	}
	private function dispatchNative(nativeEvent:NativeEvent):Void {
		// Translate the native event/signal.
		var translation:Translation<D> = translator.translate(nativeEvent);
		var data:D = translation.data;
		// Verify the passed data.
		verifyData(data);
		// Set the initial subject of the signal to the initial subject in the translation, or to the subject of this signaler 
		// if the translation does not contain one.
		var initialSubject:Subject = 
			if (translation.initialSubject == null) {
				subject;
			} else {
				translation.initialSubject;
			}
		// Dispatch the signal.
		dispatchUnsafe(data, initialSubject);
		// Bubble the signal.
		bubble(data, initialSubject);
	}
	/**
	 * Stops translating translating and re-dispatching native events/signals. Translating signalers will likely add references
	 * to native dispatchers. Calling this method will remove those references, allowing the translating signaler to be garbage
	 * collected even if the native dispatchers are not.
	 */
	public function stop(?positionInformation:PosInfos):Void {
		// Perform the same check as in the dispatch method.
		if (positionInformation.className != subjectClassName) {
			// TODO: throw a more exception instead of this lame one.
			throw "The stop method may only be called by the subject.";
		}
	}
}
package org.hsl;
/**
 * Copyright (c) 2009 Pimm Hogeling
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
 * THIS SOFTWARE IS PROVIDED BY PIMM HOGELING "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL PIMM HOGELING
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 * WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
import org.hsl.dispatching.Dispatcher;
import org.hsl.signaler.Signaler;
import org.hsl.slotlist.SlotList;
class Facade {
	public function new():Void {
	}
	public static function setupNullSlotList<D>(dispatcher:IDispatcher, signalType:String, ?signalDataType:Class<D>):Void {
		setField(dispatcher, signalType, "SlotList", new NullSlotList<D>());
	}
	public static function setupSignalType<D>(dispatcher:IDispatcher, signalType:String, ?signalDataType:Class<D>):Void {
		var signaler:ISignaler<D> = new Signaler<D>(dispatcher);
		setField(dispatcher, signalType, "Signaler", signaler);
		setField(dispatcher, signalType, "SlotList", new SlotList<D>(signaler));
	}
	private inline static function setField<D>(dispatcher:D, signalType:String, suffix:String, value:Dynamic):Void {
		Reflect.setField(dispatcher, signalType + suffix, value);
	}
}
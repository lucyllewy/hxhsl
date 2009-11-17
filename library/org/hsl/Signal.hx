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
class Signal<D> {
	/**
	 * The dispatcher that dispatched this signal. This dispatcher might be the initial dispatcher for this signal, but could
	 * also be dispatching this signal in result of bubbling.
	 */
	public var currentDispatcher(default, null):IDispatcher;
	/**
	 * The data associated with this signal.
	 */
	public var data(default, null):D;
	/**
	 * The dispatcher that initially dispatched this signal.
	 */
	public var dispatcher(default, null):IDispatcher;
	public function new(data:D, currentDispatcher:IDispatcher, dispatcher:IDispatcher):Void {
		this.data = data;
		this.currentDispatcher = currentDispatcher;
		this.dispatcher = dispatcher;
	}
	private function toString():String {
		return "[Signal data=" + Std.string(data) + " currentDispatcher=" + Std.string(currentDispatcher) + " dispatcher=" + Std.string(dispatcher) + "]";
	}
}
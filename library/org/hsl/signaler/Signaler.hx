package org.hsl.signaler;
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
import org.hsl.bridge.SignalerSlotListBridge;
import org.hsl.bubbling.Bubbler;
import org.hsl.dispatching.Dispatcher;
import org.hsl.Signal;
/**
 * The signaler is a helper that does three things. It creates the actual Signal object based on the data provider by the
 * dispatcher; it sends the signal to the slotlist it is connected to; and it bubbles the signal to the parent of the
 * dispatcher.
 */
interface ISignaler<D> {
	/**
	 * The methods defined in this object will not be used by the client in typical cases, and are therefor separated from the
	 * signaler itself.
	 */
	public var advanced(default, null):IAdvanced<D>;
	/**
	 * The bubbler of the signaler. The signaler uses the bubbler to bubble the signal.
	 */
	public var bubbler(default, setBubbler):IBubbler<D>;
	/**
	 * The dispatcher that owns this signaler. This property will be equal to the dispatcher property in the Signal objects the
	 * signaler creates.
	 */
	public var dispatcher(default, null):IDispatcher;
	/**
	 * Dispatches a signal. A Signal object will be created, passed to the connected slotlist, and bubbled to the parent of the
	 * dispatcher. The data property of the signal will equal to the data that is passed. The dispatcher property will be equal
	 * to the dispatcher property of this signaler. If the type parameter is Void, the data should be null.
	 */
	public function dispatchSignal(?data:D):Void;
	private function setBubbler(value:IBubbler<D>):IBubbler<D>;
}
/**
 * The advanced API for signalers. The methods defined in this interface will not be used by the client in typical cases, and
 * are therefor separated from the ISignaler interface.
 */
interface IAdvanced<D> {
	/**
	 * Bubbles a signal that was initially dispatched by a child of this dispatcher. This method is usually called by the
	 * signaler of that child.
	 */
	public function bubbleSignal(data:D, dispatcher:IDispatcher):Void;
	/**
	 * Connects this signaler with a slotlist. This method is usually called by the slotlist, for instance, the constructor of
	 * the SlotList class calls this method.
	 */
	public function connectWithSlotList(signalerSlotListBridge:ISignalerSlotListBridge<D>):Void;
	/**
	 * Disconnects this signaler from the slotlist it is currently connected to.
	 */
	public function disconnectFromSlotList():Void;
}
/**
 * The common ISignaler implementation.
 */
class Signaler<D> implements ISignaler<D> {
	public var advanced(default, null):IAdvanced<D>;
	public var bubbler(default, setBubbler):IBubbler<D>;
	public var dispatcher(default, null):IDispatcher;
	private var signalerSlotListBridge:ISignalerSlotListBridge<D>;
	public function new(dispatcher:IDispatcher):Void {
		if (dispatcher == null) {
			throw "The dispatcher argument must be non-null.";
		}
		this.dispatcher = dispatcher;
		advanced = new Advanced<D>(this);
		// This also calls the determineRecursive method, which is pointless. Could be fixed.
		bubbler = new NullBubbler<D>();
		disconnectFromSlotList();
	}
	public inline function connectWithSlotList(signalerSlotListBridge:ISignalerSlotListBridge<D>):Void {
		this.signalerSlotListBridge = signalerSlotListBridge;
	}
	private inline function createSignal(data:D, currentDispatcher:IDispatcher, dispatcher:IDispatcher):Signal<D> {
		return new Signal<D>(data, currentDispatcher, dispatcher);
	}
	private inline function determineRecursive(bubbler:IBubbler<D>):Bool {
		var signaler:ISignaler<D> = bubbler.findParentSignaler(dispatcher);
		while (signaler != null && signaler != this) {
			signaler = signaler.bubbler.findParentSignaler(signaler.dispatcher);
		}
		return signaler == this;
	}
	public inline function disconnectFromSlotList():Void {
		signalerSlotListBridge = new NullSignalerSlotListBridge<D>();
	}
	public function dispatchSignal(?data:D):Void {
		dispatchSignalWithDispatcher(data, dispatcher);
	}
	public inline function dispatchSignalWithDispatcher(data:D, dispatcher:IDispatcher):Void {
		signalerSlotListBridge.callSlots(createSignal(data, this.dispatcher, dispatcher));
		// Start the bubbling process.
		var parentSignaler:ISignaler<D> = bubbler.findParentSignaler(dispatcher);
		if (parentSignaler != null) {
			parentSignaler.advanced.bubbleSignal(data, dispatcher);
		}
	}
	private function setBubbler(value:IBubbler<D>):IBubbler<D> {
		// Check for recursive bubbling paths.
		if (determineRecursive(value)) {
			throw "The bubbler property of a signaler was set to a value that would result in recursive bubbling. The bubbler property has not been unset.";
		}
		return bubbler = value;
	}
	private function toString():String {
		return "[Signaler]";
	}
}
/**
 * The IAdvanced implementation for the Signaler class.
 */
class Advanced<D> implements IAdvanced<D> {
	private var signaler:Signaler<D>;
	public function new(signaler:Signaler<D>):Void {
		this.signaler = signaler;
	}
	public function bubbleSignal(data:D, dispatcher:IDispatcher):Void {
		signaler.dispatchSignalWithDispatcher(data, dispatcher);
	}
	public function connectWithSlotList(signalerSlotListBridge:ISignalerSlotListBridge<D>):Void {
		signaler.connectWithSlotList(signalerSlotListBridge);
	}
	public function disconnectFromSlotList():Void {
		signaler.disconnectFromSlotList();
	}
}
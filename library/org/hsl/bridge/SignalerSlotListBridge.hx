package org.hsl.bridge;
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
import org.hsl.Signal;
/**
 * The signaler-slotlist bridge serves as a bridge between a signaler and a slotlist. These bridges are created by the
 * slotlists and are made available to only the signaler on connection. This way the callSlots method does not have to be in
 * the ISlotList interface, which would allow the client to dispatch signals without a reference to the signaler.
 */
interface ISignalerSlotListBridge<D> {
	/**
	 * Calls all the slots in the slotlist, using the passed signal.
	 */
	public function callSlots(signal:Signal<D>):Void;
}
/**
 * A null object implementation of the ISignalerSlotListBridge interface.
 */
class NullSignalerSlotListBridge<D> implements ISignalerSlotListBridge<D> {
	public function new():Void {
	}
	public function callSlots(signal:Signal<D>):Void {
	}
}
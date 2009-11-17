package org.hsl.bubbling;
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
/**
 * The bubbler is a object used by the signaler to bubble the signal. The bubbler finds the signaler of the parent, which is
 * used by the signaler for bubbling.
 */
interface IBubbler<D> {
	/**
	 * Finds the signaler of the parent of the passed dispatcher, and returns it. Null is returned if no parent is found, or that
	 * parent does not have the correct signaler.
	 */
	public function findParentSignaler(dispatcher:IDispatcher):ISignaler<D>;
}
/**
 * A common IBubbler implementation with a fixed parent signaler.
 */
class FixedBubbler<D> implements IBubbler<D> {
	private var parentSignaler:ISignaler<D>;
	public function new(parentSignaler:ISignaler<D>):Void {
		this.parentSignaler = parentSignaler;
	}
	public function findParentSignaler(dispatcher:IDispatcher):ISignaler<D> {
		return parentSignaler;
	}
}
/**
 * A null object implementation of the IBubbler interface.
 */
class NullBubbler<D> implements IBubbler<D> {
	public function new():Void {
	}
	public function findParentSignaler(dispatcher:IDispatcher):ISignaler<D> {
		return null;
	}
}
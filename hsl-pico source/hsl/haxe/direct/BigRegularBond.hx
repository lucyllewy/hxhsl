﻿/**
 * Copyright (c) 2009-2010, The HSL Contributors.
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
package hsl.haxe.direct;
import hsl.haxe.Subject;

/**
 * A big regular bond is a bond that is created in result of a call to the bind method of a big signaler.
 */
class BigRegularBond<Datatype1, Datatype2> extends DirectSignalerBond<Datatype1, Datatype2, Void> {
	private var listener:Datatype1 -> Datatype2 -> Void;
	/**
	 * Creates a new big regular bond.
	 */
	public function new(listener:Datatype1 -> Datatype2 -> Void):Void {
		super();
		this.listener = listener;
	}
	public override function callListener(data1:Datatype1, data2:Datatype2, data3:Void, currentTarget:Subject, origin:Subject, propagationStatus:PropagationStatus):Void {
		if (halted == false) {
			listener(data1, data2);
		}
	}
	#if as3 public #else private #end override function determineEquals(value:DirectSignalerBond<Datatype1, Datatype2, Void>):Bool {
		// Since the first check makes sure the type of the passed value is equal to this one, it is safe to assume that the passed
		// value has a listener property in the second. However, AS3 compilers don't like this. We have to cast it explicitly for
		// them.
		#if as3
		return Std.is(value, BigRegularBond) && Reflect.compareMethods(cast(value, BigRegularBond<Dynamic, Dynamic>).listener, listener);
		#else
		return Std.is(value, BigRegularBond) && Reflect.compareMethods((untyped value).listener, listener);
		#end
	}
}
/**
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
import hsl.haxe.GenericSignal;
import hsl.haxe.Subject;

/**
 * An advanced bond is a bond that is created in result of a call to the bindAdvanced method.
 */
class AdvancedBond<Datatype1, Datatype2, Datatype3> extends DirectSignalerBond<Datatype1, Datatype2, Datatype3> {
	private var listener:GenericSignal<Datatype1, Datatype2, Datatype3> -> Void;
	/**
	 * Creates a new advanced bond.
	 */
	public function new(listener:GenericSignal<Datatype1, Datatype2, Datatype3> -> Void):Void {
		super();
		this.listener = listener;
	}
	public override function callListener(data1:Datatype1, data2:Datatype2, data3:Datatype3, currentTarget:Subject, origin:Subject, propagationStatus:PropagationStatus):Void {
		if (halted == false) {
			var signal:GenericSignal<Datatype1, Datatype2, Datatype3> = new GenericSignal<Datatype1, Datatype2, Datatype3>(data1, data2, data3, this, currentTarget, origin);
			listener(signal);
			if (signal.propagationStopped) {
				propagationStatus.propagationStopped = true;
			}
			if (signal.immediatePropagationStopped) {
				propagationStatus.immediatePropagationStopped = true;
			}
		}
	}
	#if as3 public #else private #end override function determineEquals(value:DirectSignalerBond<Datatype1, Datatype2, Datatype3>):Bool {
		// Since the first check makes sure the type of the passed bond is equal to this one, it is safe to assume that the passed
		// bond has a listener property in the second. However, AS3 compilers don't like this. We have to cast it explicitly for
		// them.
		#if as3
		return Std.is(value, AdvancedBond) && Reflect.compareMethods(cast(value, AdvancedBond<Dynamic, Dynamic, Dynamic>).listener, listener);
		#else
		return Std.is(value, AdvancedBond) && Reflect.compareMethods((untyped value).listener, listener);
		#end
	}
}
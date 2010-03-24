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
package hsl.haxe.null;
import haxe.PosInfos;
import hsl.haxe.Bond;
import hsl.haxe.HugeSignal;
import hsl.haxe.HugeSignaler;
import hsl.haxe.Subject;

/**
 * This class is a null object implementation of the huge signaler interface. See
 * <a href="http://en.wikipedia.org/wiki/Null_Object_pattern">Null Object pattern</a> on Wikipedia for more information.
 */
class HugeNullSignaler<Datatype1, Datatype2, Datatype3> implements HugeSignaler<Datatype1, Datatype2, Datatype3> {
	public var subject(default, null):Subject;
	public var isListenedTo(getIsListenedTo, null):Bool;
	/**
	 * Creates a new huge null signaler. The passed subject will be stored as the subject property of this signaler.
	 */
	public function new(subject:Subject):Void {
		this.subject = subject;
	}
	public function addBubblingTarget(value:HugeSignaler<Datatype1, Datatype2, Datatype3>):Void {
	}
	public function bind(listener:Datatype1 -> Datatype2 -> Datatype3 -> Void):Bond {
		return new NullBond();
	}
	public function bindAdvanced(listener:HugeSignal<Datatype1, Datatype2, Datatype3> -> Void):Bond {
		return new NullBond();
	}
	public function bindVoid(listener:Void -> Void):Bond {
		return new NullBond();
	}
	public function dispatch(?data1:Datatype1, ?data2:Datatype2, ?data3:Datatype3, ?origin:Subject, ?positionInformation:PosInfos):Void {
	}
	private function getIsListenedTo():Bool {
		return false;
	}
	public function removeBubblingTarget(value:HugeSignaler<Datatype1, Datatype2, Datatype3>):Void {
	}
	#if debug
	private function toString():String {
		return "[HugeSignaler isListenedTo=false]";
	}
	#end
	public function unbind(listener:Datatype1 -> Datatype2 -> Datatype3 -> Void):Void {
	}
	public function unbindAdvanced(listener:HugeSignal<Datatype1, Datatype2, Datatype3> -> Void):Void {
	}
	public function unbindVoid(listener:Void -> Void):Void {
	}
}
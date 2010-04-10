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
import haxe.PosInfos;
import hsl.haxe.Bond;
import hsl.haxe.HugeSignal;
import hsl.haxe.HugeSignaler;
import hsl.haxe.Subject;

/**
 * A direct signaler that dispatches signals with three data objects inside. See GenericSignaler for more information on
 * signalers.
 */
class HugeDirectSignaler<Datatype1, Datatype2, Datatype3> implements HugeSignaler<Datatype1, Datatype2, Datatype3>, extends DirectSignalerBase {
	private var bubblingTargets:List<HugeSignaler<Datatype1, Datatype2, Datatype3>>;
	public var isListenedTo(getIsListenedTo, never):Bool;
	private var sentinel:SentinelBond<Datatype1, Datatype2, Datatype3>;
	/**
	 * Creates a new huge direct signaler.
	 * 
	 * The passed subject will be used as the subject of this signaler. Only the subject is allowed to call the dispatch method.
	 * Signals dispatched by this signaler will have the subject as current target, and in some cases as origin.
	 * 
	 * If the reject null data flag is set, the signaler will throw an error if the subject attempts to dispatch a signal with
	 * null as data, or the the signaler is about to bubble a signal that contains null as data.
	 */
	public function new(subject:Subject, ?rejectNullData:Bool):Void {
		super(subject, rejectNullData);
		sentinel = new SentinelBond<Datatype1, Datatype2, Datatype3>();
	}
	public function addBubblingTarget(value:HugeSignaler<Datatype1, Datatype2, Datatype3>):Void {
		if (bubblingTargets == null) {
			bubblingTargets = new List<HugeSignaler<Datatype1, Datatype2, Datatype3>>();
		}
		bubblingTargets.add(value);
	}
	public function bind(listener:Datatype1 -> Datatype2 -> Datatype3 -> Void):Bond {
		return sentinel.add(new HugeRegularBond(listener));
	}
	public function bindAdvanced(listener:HugeSignal<Datatype1, Datatype2, Datatype3> -> Void):Bond {
		return sentinel.add(new AdvancedBond<Datatype1, Datatype2, Datatype3>(listener));
	}
	public function bindVoid(listener:Void -> Void):Bond {
		return sentinel.add(new NiladicBond<Datatype1, Datatype2, Datatype3>(listener));
	}
	private inline function bubble(data1:Datatype1, data2:Datatype2, data3:Datatype3, origin:Subject):Void {
		for (bubblingTarget in bubblingTargets) {
			bubblingTarget.dispatch(data1, data2, data3, origin);
		}
	}
	public function dispatch(?data1:Datatype1, ?data2:Datatype2, ?data3:Datatype3, ?origin:Subject, ?positionInformation:PosInfos):Void {
		// Verify the caller of this method, which should be the subject of this signaler. As you can see, there's nasty hack here
		// which makes bubbling possible.
		if (positionInformation.methodName != "bubble") {
			verifyCaller(positionInformation);
		}
		// Verify the data.
		verifyData(data1);
		verifyData(data2);
		verifyData(data3);
		// Grab the origin.
		origin = getOrigin(origin);
		// Call all the listeners.
		var propagationStatus:PropagationStatus = new PropagationStatus();
		sentinel.callListener(data1, data2, data3, subject, origin, propagationStatus);
		// Bubble the signal, if propagation was not stopped.
		if (bubblingTargets != null && (propagationStatus.propagationStopped || propagationStatus.immediatePropagationStopped) == false) {
			bubble(data1, data2, data3, origin);
		}
	}
	private function getIsListenedTo():Bool {
		return sentinel.isConnected;
	}
	public function removeBubblingTarget(value:HugeSignaler<Datatype1, Datatype2, Datatype3>):Void {
		if (bubblingTargets != null) {
			bubblingTargets.remove(value);
		}
	}
	#if debug
	private function toString():String {
		return "[HugeSignaler isListenedTo=" + isListenedTo + "]";
	}
	#end
	public function unbind(listener:Datatype1 -> Datatype2 -> Datatype3 -> Void):Void {
		sentinel.remove(new HugeRegularBond(listener));
	}
	public function unbindAdvanced(listener:HugeSignal<Datatype1, Datatype2, Datatype3> -> Void):Void {
		sentinel.remove(new AdvancedBond<Datatype1, Datatype2, Datatype3>(listener));
	}
	public function unbindVoid(listener:Void -> Void):Void {
		sentinel.remove(new NiladicBond<Datatype1, Datatype2, Datatype3>(listener));
	}
}
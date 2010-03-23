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

/**
 * The propagation status contains information about how listeners reacted to being notified.
 */
class PropagationStatus {
	/**
	 * Indicates whether immediate propagation has been stopped by a listener (true) or not (false).
	 */
	public var immediatePropagationStopped:Bool;
	/**
	 * Indicates whethe propagation has been stopped by a listener (true) or not (false).
	 */
	public var propagationStopped:Bool;
	/**
	 * Creates a new propagation status.
	 */
	public function new():Void {
		// Set immediatePropagationStopped and propagationStopped to false, unless the target is flash9, as in that case the
		// default value is false anyway.
		#if !flash9
		immediatePropagationStopped = false;
		propagationStopped = false;
		#end
	}
	#if debug
	private function toString():String {
		return "[PropagationStatus immediatePropagationStopped=" + immediatePropagationStopped + " propagationStopped=" + propagationStopped + "]";
	}
	#end
}
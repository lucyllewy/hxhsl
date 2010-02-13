package org.hsl.haxe.direct;

/**
 * The slot call status contains information about how slots reacted to being called.
 */
class SlotCallStatus {
	/**
	 * Indicates whether the bubbling has been stopped by a slot (true) or not (false).
	 */
	public var bubblingStopped:Bool;
	/**
	 * Indicates whether the propagation has been stopped by a slot (true) or not (false).
	 */
	public var propagationStopped:Bool;
	/**
	 * Creates a new slot call status.
	 */
	public function new():Void {
		// Set bubblingStopped and propagationStopped to false, unless the target is flash9, as in that case the default value
		// is false anyway.
		#if !flash9
		bubblingStopped = false;
		propagationStopped = false;
		#end
	}
}
package org.ilumbo.hslexample.colorpicker.countdown;
import org.hsl.haxe.Signaler;

interface CountdownTimer {
	// Define a signaler in the interface, as this allows the outside world to use the signaler regardless of which
	// implementation of the interface is used.
	public var completedSignaler:Signaler<Void>;
	public function reset():Void;
	public function step():Void;
}
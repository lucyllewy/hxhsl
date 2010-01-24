package org.ilumbo.hslexample.colorpicker.countdown;
import org.hsl.haxe.NullSignaler;
import org.hsl.haxe.Signaler;

class NullCountdownTimer implements CountdownTimer {
	public var completedSignaler:Signaler<Void>;
	public function new():Void {
		// Set up a null signaler, as this implementation will never complete and therefore no real signaler is required.
		completedSignaler = new NullSignaler<Void>(this);
	}
	public function reset():Void {
	}
	public function step():Void {
	}
}
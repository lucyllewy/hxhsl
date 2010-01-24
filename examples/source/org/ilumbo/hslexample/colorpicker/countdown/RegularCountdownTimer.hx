package org.ilumbo.hslexample.colorpicker.countdown;
import org.hsl.haxe.direct.DirectSignaler;
import org.hsl.haxe.Signaler;

class RegularCountdownTimer implements CountdownTimer {
	public var completedSignaler:Signaler<Void>;
	private var numberOfSteps:UInt;
	private var numberOfStepsLeft:UInt;
	public function new(numberOfSteps:UInt):Void {
		this.numberOfSteps = numberOfSteps;
		// Set up a direct signaler.
		completedSignaler = new DirectSignaler<Void>(this);
		reset();
	}
	public inline function reset():Void {
		numberOfStepsLeft = numberOfSteps;
	}
	public function step():Void {
		if (--numberOfStepsLeft == 0) {
			// Dispatch a signal to inform whoever is listening that this countdown timer has completed.
			completedSignaler.dispatch();
		}
	}
}
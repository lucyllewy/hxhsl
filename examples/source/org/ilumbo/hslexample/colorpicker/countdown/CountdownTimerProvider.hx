package org.ilumbo.hslexample.colorpicker.countdown;

class CountdownTimerProvider {
	public function new():Void {
	}
	public function provide(shiftKeyDown:Bool):CountdownTimer {
		if (shiftKeyDown) {
			return new NullCountdownTimer();
		} else {
			return new RegularCountdownTimer(96);
		}
	}
}
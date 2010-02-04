package org.ilumbo.hslexample.colorpicker;
import flash.events.Event;
import flash.Lib;
import org.hsl.avm2.translation.AVM2TranslatingSignaler;
import org.hsl.avm2.translation.mouse.ModifierKeysState;
import org.hsl.haxe.Signal;
import org.ilumbo.hslexample.colorpicker.colorpicker.ColorPicker;
import org.ilumbo.hslexample.colorpicker.colorpicker.HueSaturationLightnessType;
import org.ilumbo.hslexample.colorpicker.colorpicker.RedGreenBlueType;
import org.ilumbo.hslexample.colorpicker.colorpicker.Type;
import org.ilumbo.hslexample.colorpicker.countdown.CountdownTimer;
import org.ilumbo.hslexample.colorpicker.countdown.CountdownTimerProvider;
import org.ilumbo.hslexample.colorpicker.shapes.ColorableShape;
import org.ilumbo.hslexample.colorpicker.shapes.Square;

class Main {
	public static function main():Void {
		new Main();
	}
	private var coloringShape:ColorableShape;
	private var colorPicker:ColorPicker;
	private var countdownTimer:CountdownTimer;
	private var countdownTimerProvider:CountdownTimerProvider;
	public function new():Void {
		createSquares();
		countdownTimerProvider = new CountdownTimerProvider();
	}
	/**
	 * Updates the color of the colorable shape to the current color of the color picker.
	 */
	private function colorColoringShape():Void {
		coloringShape.color = colorPicker.color;
	}
	/**
	 * Creates the color picker type depending on whether the control key is down or not.
	 */
	private inline function createColorPickerType(controlKeyDown:Bool):Type {
		if (controlKeyDown) {
			return new RedGreenBlueType();
		} else {
			return new HueSaturationLightnessType();
		}
	}
	/**
	 * Creates the squares on the screen.
	 */
	private inline function createSquares():Void {
		for (x in 0...10) {
			for (y in 0...6) {
				var randomColor:UInt = 0x60 + Math.floor(0x3F * Math.random());
				var square:Square = new Square((randomColor << 16) ^ (randomColor << 8) ^ randomColor);
				square.x = 80 + 64 * x;
				square.y = 20 + 64 * y;
				// When the user clicks on a square, call the startColoringShape method. We're using a regular slot here, so the entire
				// signal will be passed to that method. The signal contains, among others, the subject that is currently dispatching
				// the signal which in this case is the square.
				square.clickedSignaler.addSlot(startColoringShape);
				Lib.current.addChild(square.view);
			}
		}
	}
	/**
	 * Removes the color picker, if one is present.
	 */
	private function removeColorPicker():Void {
		if (colorPicker != null) {
			// Remove the slot created in the startColoringShape method, as the colorColoringShape method no longer has to be called
			// when the color of the color picker changes.
			colorPicker.colorChangedSignaler.removeNiladicSlot(colorColoringShape);
			Lib.current.removeChild(colorPicker.view);
			colorPicker = null;
			// Remove the slot created in the startColoringShape method, as the removeColorPicker method no longer has to be called
			// when the countdown timer is complete.
			countdownTimer.completedSignaler.removeNiladicSlot(removeColorPicker);
			countdownTimer = null;
			Lib.current.removeEventListener(Event.ENTER_FRAME, step);
		}
	}
	/**
	 * Adds a color picker, wires it up with the colorable shape that was clicked on and wires it up with the countdown timer.
	 */
	private function startColoringShape(signal:Signal<ModifierKeysState>):Void {
		removeColorPicker();
		// The currentSubject in this case is the colorable shape the user clicked on. Cast it to ColorableShape and store it.
		coloringShape = cast(signal.currentSubject, ColorableShape);
		colorPicker = new ColorPicker(createColorPickerType(signal.data.controlKeyDown), coloringShape.color);
		// When the color of the color picker changes, call the colorColoringShape method. We're using a niladic slot, as that
		// method does not need any extra data to be able to work, such as the signal.
		colorPicker.colorChangedSignaler.addNiladicSlot(colorColoringShape);
		colorPicker.view.x = 336;
		colorPicker.view.y = 430;
		Lib.current.addChild(colorPicker.view);
		countdownTimer = countdownTimerProvider.provide(signal.data.shiftKeyDown);
		// When the countdown timer is completed, call the removeColorPicker method. This will remove the color picker. Again,
		// niladic slot as the method does not need any extra data.
		countdownTimer.completedSignaler.addNiladicSlot(removeColorPicker);
		// When the color of the color picker changes, reset the countdown timer. This way, the color picker will not be closed for
		// as long as the user is using it.
		colorPicker.colorChangedSignaler.addNiladicSlot(countdownTimer.reset);
		new AVM2TranslatingSignaler<Void>(this, Lib.current.stage, Event.ENTER_FRAME).addNiladicSlot(step);
	}
	/**
	 * Steps the color picker, and the countdown timer.
	 */
	private function step():Void {
		colorPicker.step();
		countdownTimer.step();
	}
}
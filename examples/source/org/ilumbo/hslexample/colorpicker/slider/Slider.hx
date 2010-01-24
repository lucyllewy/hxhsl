package org.ilumbo.hslexample.colorpicker.slider;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.BitmapFilterQuality;
import flash.filters.DropShadowFilter;
import org.hsl.avm2.translation.AVM2TranslatingSignaler;
import org.hsl.avm2.translation.mouse.LocalMouseLocation;
import org.hsl.avm2.translation.mouse.MouseLocationTranslator;
import org.hsl.haxe.direct.DirectSignaler;
import org.hsl.haxe.Signaler;
import org.hsl.haxe.Slot;
import org.ilumbo.hslexample.colorpicker.slider.backgrounddrawing.BackgroundDrawer;

class Slider {
	private var _view:View;
	private var indicatorMover:IndicatorMover;
	private var mouseMovedSlot:Slot<LocalMouseLocation>;
	private var mouseReleasedSlot:Slot<Void>;
	public var value(default, setValue):Float;
	public var valueChangedSignaler:Signaler<Void>;
	public var view(default, null):DisplayObject;
	public var width(default, null):Float;
	public function new(width:Float, initialValue:Float, indicator:Indicator, indicatorMover:IndicatorMover, backgroundDrawer:BackgroundDrawer):Void {
		this.width = width;
		this.indicatorMover = indicatorMover;
		// Set up a direct signaler.
		valueChangedSignaler = new DirectSignaler<Void>(this);
		value = initialValue;
		view = _view = new View(width, indicator, backgroundDrawer);
		// When the user clicks on the view of the slider, call the startDragging method. We're using a niladic slot, as that
		// method does not need any extra data to be able to work, such as the mouse location.
		_view.mouseClickedSignaler.addNiladicSlot(startDragging);
		// When the user clicks on the view of the slider, also call the respondToMouseLocation method. We're using a simple slot,
		// as that method neds the mouse location (but not the rest of the signal).
		_view.mouseClickedSignaler.addSimpleSlot(respondToMouseLocation);
	}
	private function respondToMouseLocation(mouseLocation:LocalMouseLocation):Void {
		value = Math.min(Math.max(mouseLocation.translateToScope(_view).x / width, 0), 1);
	}
	private inline function setValue(value:Float):Float {
		this.value = value;
		indicatorMover.moveIndicator(value * width);
		// Dispatch a signal to informs whoever is listening that the value (property) has changed.
		valueChangedSignaler.dispatch();
		return value;
	}
	private function startDragging():Void {
		// From now on, when the user moves the mouse, call the respondToMouseLocation method. We're storing the slot, so it'll be
		// easier to destroy (once the user releases the mouse button).
		mouseMovedSlot = _view.mouseMovedSignaler.addSimpleSlot(respondToMouseLocation);
		// From now on, when the user releases the mouse button, call the stopDragging method. Again, storing the slot for easy
		// destroying.
		mouseReleasedSlot = _view.mouseReleasedSignaler.addNiladicSlot(stopDragging);
	}
	private function stopDragging():Void {
		// Destroy the slots created in the startDragging method, so the slider will no longer react when the user moves the mouse
		// or releases the mouse button.
		mouseMovedSlot.destroy();
		mouseReleasedSlot.destroy();
	}
}
private class View extends Sprite {
	private static inline var HEIGHT:Float = 14;
	public var mouseClickedSignaler:Signaler<LocalMouseLocation>;
	public var mouseMovedSignaler:Signaler<LocalMouseLocation>;
	public var mouseReleasedSignaler:Signaler<Void>;
	public function new(width:Float, indicator:Indicator, backgroundDrawer:BackgroundDrawer):Void {
		super();
		// Set up an AVM2 translating signaler that translates MouseEvent.MOUSE_DOWN events to signals containing the location of
		// the mouse. The last true argument makes the signaler throw an error if someone would accidentally do
		// mouseClickedSignaler.dispatch(null), as doing that might upset whoever is listening.
		mouseClickedSignaler = new AVM2TranslatingSignaler<LocalMouseLocation>(this, this, MouseEvent.MOUSE_DOWN, new MouseLocationTranslator(), true);
		// Add an event listener so the two signalers that depend on the stage will be instantiated when the stage becomes
		// available. This could be risky, as the outside world might try to add slots to those two listeners before the stage
		// becomes available which would produce null object reference errors. Wrapping the stage might be a solution here.
		addEventListener(Event.ADDED_TO_STAGE, instantiateStageSignalers);
		addChild(indicator.view);
		backgroundDrawer.drawBackground(this, 0, -.5 * HEIGHT, width, HEIGHT);
		buttonMode = true;
		setupFilter();
	}
	private function instantiateStageSignalers(event:Event):Void {
		// Remove the listener, as this method only has to be called once.
		removeEventListener(Event.ADDED_TO_STAGE, instantiateStageSignalers);
		// Set up an AVM2 translating signaler that translates MouseEvent.MOUSE_MOVE events that come from the stage to signals
		// containing the location of the mouse. Again, reject null data.
		mouseMovedSignaler = new AVM2TranslatingSignaler<LocalMouseLocation>(this, stage, MouseEvent.MOUSE_MOVE, new MouseLocationTranslator(), true);
		// Set up an AVM2 translating signaler that translates MouseEvent.MOUSE_UP events that come from the stage to "empty"
		// signals.
		mouseReleasedSignaler = new AVM2TranslatingSignaler<Void>(this, stage, MouseEvent.MOUSE_UP);
	}
	private inline function setupFilter():Void {
		var filters:Array<Dynamic> = filters;
		filters.push(new DropShadowFilter(2, 225, 0x3F3F3F, .5, 1, 1, 1, BitmapFilterQuality.HIGH, true));
		this.filters = filters;
	}
}
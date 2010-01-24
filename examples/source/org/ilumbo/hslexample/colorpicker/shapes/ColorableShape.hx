package org.ilumbo.hslexample.colorpicker.shapes;
import flash.display.DisplayObject;
import org.hsl.avm2.translation.mouse.ModifierKeysState;
import org.hsl.haxe.Signaler;

interface ColorableShape {
	// Define a signaler in the interface, as this allows the outside world to use the signaler regardless of which
	// implementation of the interface is used.
	public var clickedSignaler(default, null):Signaler<ModifierKeysState>;
	public var color(default, setColor):UInt;
	public var view(default, null):DisplayObject;
	private function setColor(value:UInt):UInt;
}
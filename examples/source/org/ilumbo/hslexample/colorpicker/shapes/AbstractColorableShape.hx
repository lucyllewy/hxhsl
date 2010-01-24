package org.ilumbo.hslexample.colorpicker.shapes;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import org.hsl.avm2.translation.AVM2TranslatingSignaler;
import org.hsl.avm2.translation.mouse.ModifierKeysState;
import org.hsl.avm2.translation.mouse.ModifierKeysStateTranslator;
import org.hsl.haxe.Signaler;

class AbstractColorableShape extends Sprite, implements ColorableShape {
	public var color(default, setColor):UInt;
	public var clickedSignaler:Signaler<ModifierKeysState>;
	public var view(default, null):DisplayObject;
	public function new(initialColor:UInt):Void {
		super();
		// Set up an AVM2 translating signaler that thanslates MouseEvent.CLICK events to signals containing the modifier keys state.
		clickedSignaler = new AVM2TranslatingSignaler<ModifierKeysState>(this, this, MouseEvent.CLICK, new ModifierKeysStateTranslator(), true);
		buttonMode = true;
		view = this;
		color = initialColor;
	}
	public function setColor(value:UInt):UInt {
		return color = value;
	}
}
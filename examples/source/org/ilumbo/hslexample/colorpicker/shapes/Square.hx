package org.ilumbo.hslexample.colorpicker.shapes;

class Square extends AbstractColorableShape {
	public function new(initialColor:UInt):Void {
		super(initialColor);
	}
	public override function setColor(value:UInt):UInt {
		graphics.clear();
		graphics.beginFill(value);
		graphics.drawRect(0, 0, 64, 64);
		graphics.endFill();
		return super.setColor(value);
	}
}
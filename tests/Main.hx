package ;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import org.hsl.haxe.direct.DirectSignaler;
import org.hsl.haxe.Signaler;
import org.hsl.haxe.Signal;
 
class Main extends Sprite
{
	private var _signaler:Signaler<Int>;
	private var _tracer:TextField;
	
	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}
	
	
	public function new()
	{
		super();
		this._signaler = new DirectSignaler<Int>(this);
		this._tracer = new TextField();
		super.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
	}
	
	private function addedToStageHandler(event:Event):Void
	{
		untyped __global__["flash.debugger.enterDebugger"]();
		super.removeEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		this.stage.align = StageAlign.TOP_LEFT;
		this.stage.scaleMode = StageScaleMode.NO_SCALE;
		this._tracer.defaultTextFormat = new TextFormat("_sans");
		this._tracer.width = this.stage.stageWidth;
		this._tracer.height = this.stage.stageHeight;
		this._tracer.multiline = true;
		super.addChild(this._tracer);
		this.test();
	}
	
	/**
	 * Signaler addSimpleSlot 2
	 * Signaler dispatch 2
	 * 
	 * Note: there isn't priority sorting in Signaler.
	 * Note: Flex profiler cannot profile SWF compiled with HaXe. :-(
	 * I've got some raw profiling info, but it's difficult to analize that.
	 */
	private function test():Void
	{
		var t:Int = Lib.getTimer();
		for (i in 0...1000)
		{
			this._signaler.addSimpleSlot(function(param:Int):Void { });
		}
		this._tracer.appendText("Signaler addSimpleSlot " + (Lib.getTimer() - t) + "\r\n");
		t = Lib.getTimer();
		this._signaler.dispatch(100);
		this._tracer.appendText("Signaler dispatch " + (Lib.getTimer() - t) + "\r\n");
	}
}
package tests 
{
	//{ imports
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import org.osflash.signals.DeluxeSignal;
	import org.wvxvws.signals.ISemaphore;
	import org.wvxvws.signals.Signals;
	//}
	
	/**
	 * TestSignalvsDispatcher class.
	 * @author wvxvw
	 * @langVersion 3.0
	 * @playerVersion 10.0.32
	 */
	public class TestSignalvsDispatcher extends Sprite implements ISemaphore
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		public static const FOO:Vector.<Class> = new <Class>[int];
		public static const BAR:Vector.<Class> = new <Class>[String, int];
		
		/* INTERFACE org.wvxvws.signals.ISemaphore */
		
		public function get signals():Signals { return this._signals; }
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _field:TextField = new TextField();
		private var _eventDispatcher:EventDispatcher = new EventDispatcher();
		private var _signals:Signals;
		private var _delux:DeluxeSignal;
		private var _signalTypes:Vector.<Vector.<Class>> = new <Vector.<Class>>[FOO, BAR];
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function TestSignalvsDispatcher() 
		{
			super();
			super.stage.align = StageAlign.TOP_LEFT;
			super.stage.scaleMode = StageScaleMode.NO_SCALE;
			this._field.defaultTextFormat = new TextFormat("_sans");
			this._field.multiline = true;
			this._field.width = super.stage.stageWidth;
			this._field.height = super.stage.stageHeight;
			super.addChild(this._field);
			this._signals = new Signals(this);
			this._delux = new DeluxeSignal(this, int);
			this.testPriority();
		}
		
		/**
		 * Results:
		 * 
		 * 		EventDispatcer addEventListener (priority) 38
		 * 		EventDispatcer dispatchEvent 1
		 * 		Signals add (priority) 5
		 * 		Signals call 4
		 * 		DeluxeSignal add (priority) 170
		 * 		DeluxeSignal dispatch 1
		 * 
		 * Note: if you go one order higher for "i", the priority sorting
		 * will increace geometrically. Not recommended for testing.
		 * 
		 * Note: EventDispatcher doesn't provide a way to get all attached handlers.
		 * Note: EventDispatcher provides filtering for handlers, however, 
		 * the filteing relies on string comparision - thus error prone.
		 * Note: EventDispatcher doesn't allow for carrying a value along with 
		 * the basic event, you would have to create a new event class to be able
		 * to pass a value.
		 * 
		 * Note: DeluxeSignal doesn't provide filtering on event type.
		 * Note: DeluxeSignal cannot add weak handlers.
		 * 
		 * Note: Signals is the slowest, and yet does not provide compile time type
		 * safety.
		 * 
		 * Please see the profiler screenshots for memory details. 
		 * Your mileage may vary!
		 */
		private function testPriority():void
		{
			var event:FooEvent = new FooEvent("foo", 100);
			var i:int = 1000;
			var t:int = getTimer();
			
			//------------------------EventDispatcher-------------------------------
			
			while (i--)
			{
				this._eventDispatcher.addEventListener(
					"foo", function(e:Event):void { }, 
					false, Math.random() * int.MAX_VALUE);
			}
			this._field.appendText(
				"EventDispatcer addEventListener (priority) " + 
				(getTimer() - t) + "\r\n");
			i = 1000;
			t = getTimer();
			this._eventDispatcher.dispatchEvent(event);
			this._field.appendText(
				"EventDispatcer dispatchEvent " + (getTimer() - t) + "\r\n");
			
			//----------------------------Signals-----------------------------------
			
			i = 1000;
			t = getTimer();
			while (i--)
			{
				this._signals.add(FOO, function(param:int):void { },
					Math.random() * int.MAX_VALUE);
			}
			this._field.appendText(
				"Signals add (priority) " + (getTimer() - t) + "\r\n");
			t = getTimer();
			this._signals.call(FOO, 100);
			this._field.appendText(
				"Signals call " + (getTimer() - t) + "\r\n");
			
			//---------------------------DeluxeSignal-------------------------------
			
			i = 1000;
			t = getTimer();
			while (i--)
			{
				this._delux.add(function(param:int):void { },
					Math.random() * int.MAX_VALUE);
			}
			this._field.appendText(
				"DeluxeSignal add (priority) " + (getTimer() - t) + "\r\n");
			t = getTimer();
			this._delux.dispatch(100);
			this._field.appendText(
				"DeluxeSignal dispatch " + (getTimer() - t) + "\r\n");
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/* INTERFACE org.wvxvws.signals.ISemaphore */
		
		public function signalTypes():Vector.<Vector.<Class>>
		{
			return this._signalTypes;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
}
//{ imports
import flash.events.Event;
//}

/**
 * FooEvent event.
 * @author wvxvw
 * @langVersion 3.0
 * @playerVersion 10.0.32
 */
internal final class FooEvent extends Event 
{
	//--------------------------------------------------------------------------
	//
	//  Public properties
	//
	//--------------------------------------------------------------------------
	
	public function get data():int { return this._data; }
	
	//--------------------------------------------------------------------------
	//
	//  Private properties
	//
	//--------------------------------------------------------------------------
	
	private var _data:int;
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	
	public function FooEvent(type:String, data:int) 
	{ 
		super(type);
		this._data = data;
	} 
	
	//--------------------------------------------------------------------------
	//
	//  Public methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Note this method does not create a new event instance. 
	 * It returns the reference to this event.
	 */
	public override function clone():Event
	{
		return new FooEvent(super.type, this._data);
	} 
	
	public override function toString():String 
	{ 
		return super.formatToString("FooEvent", "type");
	}
}
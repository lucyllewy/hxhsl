package hsl.haxe.plugins;
import haxe.Timer;
import hsl.haxe.translating.DynamicFunctionSignaler;
import hsl.haxe.Signaler;

class TimerShortcuts {
	private static inline var TICKED:String = "ticked";
	private static var signalerVault:SignalerVault;
	private static function createTickedSignaler(nativeDispatcher:Dynamic):Signaler<Void> {
		return new DynamicFunctionSignaler<Void>(nativeDispatcher, nativeDispatcher, "run");
	}
	/**
	 * Gets a signaler that dispatches signals when the timer reaches an interval specified in the constructor of the timer. This
	 * method either creates a new signaler, or uses an existing one, depending on whether this method has been called before. If
	 * you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getTickedSignaler(nativeDispatcher:Timer):Signaler<Void> {
		if (null == signalerVault) {
			signalerVault = new SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, TICKED, createTickedSignaler);
	}
}
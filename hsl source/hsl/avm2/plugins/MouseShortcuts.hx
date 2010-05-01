package hsl.avm2.plugins;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import hsl.avm2.data.mouse.MouseCondition;
import hsl.avm2.data.mouse.MouseLocation;
import hsl.avm2.translation.DatalessTranslator;
import hsl.avm2.translation.mouse.DeltaTranslator;
import hsl.avm2.translation.mouse.MouseConditionTranslator;
import hsl.avm2.translation.mouse.MouseLocationTranslator;
import hsl.haxe.Signaler;

class MouseShortcuts {
	private static var signalerVault:AVM2SignalerVault;
	private static function createDatalessTranslator<Datatype>():DatalessTranslator<Datatype> {
		return new DatalessTranslator<Datatype>();
	}
	private static function createDeltaTranslator():DeltaTranslator {
		return new DeltaTranslator();
	}
	private static function createMouseConditionTranslator():MouseConditionTranslator {
		return new MouseConditionTranslator();
	}
	private static function createMouseLocationTranslator():MouseLocationTranslator {
		return new MouseLocationTranslator();
	}
	public static inline function getClickedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.CLICK, createMouseConditionTranslator);
	}
	public static inline function getMouseMovedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseLocation> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MOUSE_MOVE, createMouseLocationTranslator);
	}
	public static inline function getMouseRolledOutSignaler(nativeDispatcher:InteractiveObject):Signaler<Void> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.ROLL_OUT, createDatalessTranslator);
	}
	public static inline function getMouseRolledOverSignaler(nativeDispatcher:InteractiveObject):Signaler<Void> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.ROLL_OVER, createDatalessTranslator);
	}
	public static inline function getScrolledOnSignaler(nativeDispatcher:InteractiveObject):Signaler<Int> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MOUSE_WHEEL, createDeltaTranslator);
	}
}
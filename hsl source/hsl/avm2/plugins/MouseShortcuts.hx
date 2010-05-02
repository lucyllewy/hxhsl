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
	/**
	 * Gets a signaler that dispatches signals when the user clicks on the object using the left mouse button. User interaction
	 * is considered a click when the user pushes the left mouse button down on the object, and then lets the mouse button up
	 * again on the same object. The mouse cursor may exit and enter the object meanwhile. The dispatched signals contain the
	 * mouse condition. This method either creates a new signaler, or uses an existing one, depending on whether this method has
	 * been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getClickedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.CLICK, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the mouse cursor enters (moves onto) the object. This method either creates a
	 * new signaler, or uses an existing one, depending on whether this method has been called before. If you call this method
	 * twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getMouseEnteredSignaler(nativeDispatcher:InteractiveObject):Signaler<Void> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.ROLL_OVER, createDatalessTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the mouse cursor exits the object. This method either creates a new signaler,
	 * or uses an existing one, depending on whether this method has been called before. If you call this method twice on the
	 * same object, the same signaler instance will be returned.
	 */
	public static inline function getMouseExitedSignaler(nativeDispatcher:InteractiveObject):Signaler<Void> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.ROLL_OUT, createDatalessTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the mouse cursor moves to a place on the object. The dispatched signals
	 * contain the new location of the mouse. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getMouseMovedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseLocation> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MOUSE_MOVE, createMouseLocationTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user pushes the left mouse button down on the object. The dispatched
	 * signals contain the mouse condition. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getPressedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MOUSE_DOWN, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user lets the left mouse button up on the object. The user can push the
	 * mouse button down, and then move onto the object and let it up. A signal is dispatched in such cases, too. The dispatched
	 * signals contain the mouse condition. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getReleasedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MOUSE_UP, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user uses the scroll wheel when the mouse cursor is on the object. The
	 * dispatched signals contain the delta. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getScrolledOnSignaler(nativeDispatcher:InteractiveObject):Signaler<Int> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MOUSE_WHEEL, createDeltaTranslator);
	}
}
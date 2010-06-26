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

/**
 * Shortcuts for mouse actions that are AIR-specific.
 */
class AIRMouseShortcuts {
	private static var signalerVault:AVM2SignalerVault;
	private static function createMouseConditionTranslator():MouseConditionTranslator {
		return new MouseConditionTranslator();
	}
	/**
	 * Gets a signaler that dispatches signals when the user clicks on the object using the middle mouse button. User interaction
	 * is considered a click when the user pushes the middle mouse button down on the object, and then lets the mouse button up
	 * again on the same object. The mouse cursor may exit and enter the object meanwhile. The dispatched signals contain the
	 * mouse condition. This method either creates a new signaler, or uses an existing one, depending on whether this method has
	 * been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getMiddleClickedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MIDDLE_CLICK, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user pushes the middle mouse button down on the object. The dispatched
	 * signals contain the mouse condition. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getMiddlePressedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MIDDLE_MOUSE_DOWN, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user lets the middle mouse button up on the object. The user can push the
	 * mouse button down, and then move onto the object and let it up. A signal is dispatched in such cases, too. The dispatched
	 * signals contain the mouse condition. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getMiddleReleasedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.MIDDLE_MOUSE_UP, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user clicks on the object using the right mouse button. User interaction
	 * is considered a click when the user pushes the right mouse button down on the object, and then lets the mouse button up
	 * again on the same object. The mouse cursor may exit and enter the object meanwhile. The dispatched signals contain the
	 * mouse condition. This method either creates a new signaler, or uses an existing one, depending on whether this method has
	 * been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getRightClickedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.RIGHT_CLICK, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user pushes the right mouse button down on the object. The dispatched
	 * signals contain the mouse condition. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getRightPressedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.RIGHT_MOUSE_DOWN, createMouseConditionTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user lets the right mouse button up on the object. The user can push the
	 * mouse button down, and then move onto the object and let it up. A signal is dispatched in such cases, too. The dispatched
	 * signals contain the mouse condition. This method either creates a new signaler, or uses an existing one, depending on
	 * whether this method has been called before. If you call this method twice on the same object, the same signaler instance
	 * will be returned.
	 */
	public static inline function getRightReleasedSignaler(nativeDispatcher:InteractiveObject):Signaler<MouseCondition> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, MouseEvent.RIGHT_MOUSE_UP, createMouseConditionTranslator);
	}
}
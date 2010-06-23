package hsl.avm2.plugins;
import flash.events.KeyboardEvent;
import hsl.avm2.translation.keyboard.KeyCombinationTranslator;
import hsl.haxe.data.keyboard.KeyCombination;
import hsl.haxe.Signaler;
import flash.display.InteractiveObject;

class KeyboardShortcuts {
	private static var signalerVault:AVM2SignalerVault;
	private static function createKeyCombinationTranslator():KeyCombinationTranslator {
		return new KeyCombinationTranslator();
	}
	/**
	 * Gets a signaler that dispatches signals when the user presses a key on the keyboard down. The dispatched signals contain
	 * the key combination. This method either creates a new signaler, or uses an existing one, depending on whether this method
	 * has been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getKeyPressedDownSignaler(nativeDispatcher:InteractiveObject):Signaler<KeyCombination> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, KeyboardEvent.KEY_DOWN, createKeyCombinationTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when the user lets a key on the keyboard up. The dispatched signals contain the
	 * key combination. This method either creates a new signaler, or uses an existing one, depending on whether this method has
	 * been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getKeyLetUpSignaler(nativeDispatcher:InteractiveObject):Signaler<KeyCombination> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, KeyboardEvent.KEY_UP, createKeyCombinationTranslator);
	}
}
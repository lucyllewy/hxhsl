package hsl.avm2.plugins;
import hsl.avm2.translating.AVM2Signaler;
import hsl.haxe.Signaler;
import hsl.haxe.translation.Translator;
import flash.events.IEventDispatcher;
import flash.utils.TypedDictionary;

class AVM2SignalerVault {
	private var signalers:TypedDictionary<IEventDispatcher, Hash<Signaler<Dynamic>>>;
	public function new():Void {
		signalers = new TypedDictionary<IEventDispatcher, Hash<Signaler<Dynamic>>>();
	}
	/**
	 * Gets a translating signaler for the passed native dispatcher and the passed native event type. This method creates a new
	 * translating signaler if it cannot find one that has been created earlier. If a new translating signaler is created, the
	 * passed createTranslator function is called to create a translator.
	 */
	public function getSignaler<Datatype>(nativeDispatcher:IEventDispatcher, nativeEventType:String, createTranslator:Void -> Translator<Datatype>):Signaler<Datatype> {
		var hash:Hash<Signaler<Dynamic>> =
			// If a hash for this native dispatcher already exists, return it.
			if (signalers.exists(nativeDispatcher)) {
				signalers.get(nativeDispatcher);
			// If there is no hash for this native dispatcher, create it, add it and return it.
			} else {
				var result:Hash<Signaler<Dynamic>> = new Hash<Signaler<Dynamic>>();
				signalers.set(nativeDispatcher, result);
				result;
			}
		return
			// If the hash contains a signaler for this native event type, return it.
			if (hash.exists(nativeEventType)) {
				hash.get(nativeEventType);
			} else {
			// If there is no signaler for this native event type, create it, add it and return it.
				var result:Signaler<Datatype> = new AVM2Signaler<Datatype>(nativeDispatcher, nativeDispatcher, nativeEventType, createTranslator());
				hash.set(nativeEventType, result);
				return result;
			}
	}
}
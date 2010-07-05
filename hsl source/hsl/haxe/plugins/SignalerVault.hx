package hsl.haxe.plugins;
import hsl.haxe.Signaler;

/**
 * A vault that stores signalers.
 */
class SignalerVault<NativeDispatcherType> {
	private var signalerCells:Hash<List<SignalerCell<NativeDispatcherType>>>;
	/**
	 * Creates a new signaler vault.
	 */
	public function new():Void {
		signalerCells = new Hash<List<SignalerCell<NativeDispatcherType>>>();
	}
	/**
	 * Gets a signaler for the passed native dispatcher and the passed signal identifier. This method creates a new signaler if
	 * it cannot find one that has been created earlier. New signalers are created using the passed createSignaler function.
	 */
	public function getSignaler<Datatype>(nativeDispatcher:NativeDispatcherType, signalIdentifier:String, createSignaler:NativeDispatcherType -> Signaler<Datatype>):Signaler<Datatype> {
		var signalerCellList:List<SignalerCell<NativeDispatcherType>> =
			if (signalerCells.exists(signalIdentifier)) {
				signalerCells.get(signalIdentifier);
			} else {
				var result:List<SignalerCell<NativeDispatcherType>> = new List<SignalerCell<NativeDispatcherType>>();
				signalerCells.set(signalIdentifier, result);
				result;
			}
		for (signalerCell in signalerCellList) {
			if (signalerCell.nativeDispatcher == nativeDispatcher) {
				return untyped signalerCell.signaler;
			}
		}
		var result:Signaler<Datatype> = createSignaler(nativeDispatcher);
		signalerCellList.add(new SignalerCell<NativeDispatcherType>(nativeDispatcher, result));
		return result;
	}
}
class SignalerCell<NativeDispatcherType> {
	public var nativeDispatcher(default, null):NativeDispatcherType;
	public var signaler(default, null):Signaler<Dynamic>;
	public function new(nativeDispatcher:NativeDispatcherType, signaler:Signaler<Dynamic>):Void {
		this.nativeDispatcher = nativeDispatcher;
		this.signaler = signaler;
	}
}
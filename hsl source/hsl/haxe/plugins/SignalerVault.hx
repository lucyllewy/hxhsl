package hsl.haxe.plugins;
import hsl.haxe.Signaler;

/**
 * A vault that stores signalers.
 */
class SignalerVault {
	private var signalerCells:Hash<List<SignalerCell>>;
	/**
	 * Creates a new signaler vault.
	 */
	public function new():Void {
		signalerCells = new Hash<List<SignalerCell>>();
	}
	/**
	 * Gets a signaler for the passed native dispatcher and the passed signal identifier. This method creates a new signaler if
	 * it cannot find one that has been created earlier. New signalers are created using the passed createSignaler function.
	 */
	public function getSignaler<Datatype>(nativeDispatcher:Dynamic, signalIdentifier:String, createSignaler:Dynamic -> Signaler<Datatype>):Signaler<Datatype> {
		var signalerCellList:List<SignalerCell> =
			if (signalerCells.exists(signalIdentifier)) {
				signalerCells.get(signalIdentifier);
			} else {
				var result:List<SignalerCell> = new List<SignalerCell>();
				signalerCells.set(signalIdentifier, result);
				result;
			}
		for (signalerCell in signalerCellList) {
			if (signalerCell.nativeDispatcher == nativeDispatcher) {
				return untyped signalerCell.signaler;
			}
		}
		var result:Signaler<Datatype> = createSignaler(nativeDispatcher);
		signalerCellList.add(new SignalerCell(nativeDispatcher, result));
		return result;
	}
}
class SignalerCell {
	public var nativeDispatcher(default, null):Dynamic;
	public var signaler(default, null):Signaler<Dynamic>;
	public function new(nativeDispatcher:Dynamic, signaler:Signaler<Dynamic>):Void {
		this.nativeDispatcher = nativeDispatcher;
		this.signaler = signaler;
	}
}
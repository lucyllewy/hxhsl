package hsl.avm2.translating;
import flash.events.IEventDispatcher;
import hsl.haxe.translation.Translator;
import hsl.haxe.Subject;

/**
 * A custom priority AVM2 signaler, is an AVM2 signaler that accepts any priority. If you're not sure what this means, use the
 * regular AVM2 signaler instead.
 */
class CustomPriorityAVM2Signaler<Datatype> extends AVM2Signaler<Datatype> {
	private var priority:Int;
	/**
	 * Creates a new custom priority AVM2 signaler.
	 */
	public function new(subject:Subject, nativeDispatcher:IEventDispatcher, nativeEventType:String, priority:Int, ?translator:Translator<Datatype>, ?rejectNullData:Bool):Void {
		super(subject, nativeDispatcher, nativeEventType, translator);
		this.priority = priority;
	}
	private override function addInternalListener():Void {
		nativeDispatcher.addEventListener(nativeEventType, dispatchNative, false, priority);
	}
}
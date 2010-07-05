package hsl.haxe.plugins;
import haxe.Http;
import hsl.haxe.data.web.HTTPStatus;
import hsl.haxe.direct.DirectSignaler;
import hsl.haxe.Subject;
import hsl.haxe.translating.DynamicFunctionSignaler;
import hsl.haxe.Signaler;

/**
 * Shortcuts for the HTTP class.
 */
class HTTPShortcuts {
	private static inline var COMPLETED:String = "completed";
	private static inline var ERROR_OCCURRED:String = "errorOccurred";
	private static inline var HTTP_STATUS_RECEIVED:String = "httpStatusReceived";
	private static var signalerVault:SignalerVault<Http>;
	private static function createCompletedSignaler(nativeDispatcher:Http):Signaler<String> {
		return new DynamicFunctionSignaler<String>(nativeDispatcher, nativeDispatcher, "onData", true);
	}
	private static function createErrorOccurredSignaler(nativeDispatcher:Http):Signaler<String> {
		return new DynamicFunctionSignaler<String>(nativeDispatcher, nativeDispatcher, "onError", true);
	}
	private static function createHTTPStatusReceivedSignaler(nativeDispatcher:Http):Signaler<HTTPStatus> {
		return new HTTPStatusReceivedSignaler(nativeDispatcher);
	}
	/**
	 * Gets a signaler that dispatches signals after all the received data is decoded. The dispatched signals contain the data
	 * that was received. This method either creates a new signaler, or uses an existing one, depending on whether this method
	 * has been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getCompletedSignaler(nativeDispatcher:Http):Signaler<String> {
		if (null == signalerVault) {
			signalerVault = new SignalerVault<Http>();
		}
		return signalerVault.getSignaler(nativeDispatcher, COMPLETED, createCompletedSignaler);
	}
	/**
	 * Gets a signaler that dispatches signals when an HTTP status is received. The dispatched signals contain the HTTP status.
	 * This method either creates a new signaler, or uses an existing one, depending on whether this method has been called
	 * before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getHTTPStatusReceivedSignaler(nativeDispatcher:Http):Signaler<HTTPStatus> {
		if (null == signalerVault) {
			signalerVault = new SignalerVault<Http>();
		}
		return signalerVault.getSignaler(nativeDispatcher, HTTP_STATUS_RECEIVED, createHTTPStatusReceivedSignaler);
	}
	/**
	 * Gets a signaler that dispatches signals when a download operation results in a fatal error that terminates the download.
	 * This includes security-related errors. The dispatched signals contain the related error message. This method either
	 * creates a new signaler, or uses an existing one, depending on whether this method has been called before. If you call this
	 * method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getErrorOccurredSignaler(nativeDispatcher:Http):Signaler<String> {
		if (null == signalerVault) {
			signalerVault = new SignalerVault<Http>();
		}
		return signalerVault.getSignaler(nativeDispatcher, ERROR_OCCURRED, createErrorOccurredSignaler);
	}
}
/**
 * A helper class that allows us to dispatch signals with HTTP statusses inside, rather than integers.
 */
class HTTPStatusReceivedSignaler extends DirectSignaler<HTTPStatus> {
	public function new(nativeDispatcher:Http):Void {
		super(nativeDispatcher);
		nativeDispatcher.onStatus = dispatchNative;
	}
	private function dispatchNative(statusCode:Int):Void {
		dispatch(new HTTPStatus(statusCode));
	}
}
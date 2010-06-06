package hsl.avm2.plugins;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import hsl.avm2.translation.error.ErrorMessageTranslator;
import hsl.avm2.translation.progress.LoadProgressTranslator;
import hsl.avm2.translation.web.HTTPStatusTranslator;
import hsl.avm2.translation.web.ReceivedDataTranslator;
import hsl.haxe.data.progress.LoadProgress;
import hsl.haxe.data.web.HTTPStatus;
import hsl.haxe.Signaler;

class URLLoaderShortcuts {
	private static var signalerVault:AVM2SignalerVault;
	private static function createDataTranslator():ReceivedDataTranslator {
		return new ReceivedDataTranslator();
	}
	private static function createHTTPStatusTranslator():HTTPStatusTranslator {
		return new HTTPStatusTranslator();
	}
	private static function createErrorMessageTranslator():ErrorMessageTranslator {
		return new ErrorMessageTranslator();
	}
	private static function createLoadProgressTranslator():LoadProgressTranslator {
		return new LoadProgressTranslator();
	}
	/**
	 * Gets a signaler that dispatches signals after all the received data is decoded. The dispatched signals contain the data
	 * that was received. This method either creates a new signaler, or uses an existing one, depending on whether this method
	 * has been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getCompletedSignaler(nativeDispatcher:URLLoader):Signaler<Dynamic> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, Event.COMPLETE, createDataTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when data is received as the download operation progresses. Note that with a
	 * URLLoader object, it is not possible to access the data until it has been received completely. So, the progress event only
	 * serves as a notification of how far the download has progressed. To access the data before it's entirely downloaded, use a
	 * URLStream object. This method either creates a new signaler, or uses an existing one, depending on whether this method has
	 * been called before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getDataReceivedSignaler(nativeDispatcher:URLLoader):Signaler<LoadProgress> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, ProgressEvent.PROGRESS, createLoadProgressTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when an HTTP status is received. The dispatched signals contain the HTTP status.
	 * This method either creates a new signaler, or uses an existing one, depending on whether this method has been called
	 * before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getHTTPStatusReceivedSignaler(nativeDispatcher:URLLoader):Signaler<HTTPStatus> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, HTTPStatusEvent.HTTP_STATUS, createHTTPStatusTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when a download operation results in a fatal error that terminates the download.
	 * The dispatched signals contain the related error message. This method either creates a new signaler, or uses an existing
	 * one, depending on whether this method has been called before. If you call this method twice on the same object, the same
	 * signaler instance will be returned.
	 */
	public static inline function getIOErrorOccurredSignaler(nativeDispatcher:URLLoader):Signaler<String> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, IOErrorEvent.IO_ERROR, createErrorMessageTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when a download operation attempts to download data from a server outside the
	 * security sandbox. The dispatched signals contain the related error message. This method either creates a new signaler, or
	 * uses an existing one, depending on whether this method has been called before. If you call this method twice on the same
	 * object, the same signaler instance will be returned.
	 */
	public static inline function getSecurityErrorOccurredSignaler(nativeDispatcher:URLLoader):Signaler<String> {
		if (signalerVault == null) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(nativeDispatcher, SecurityErrorEvent.SECURITY_ERROR, createErrorMessageTranslator);
	}
}
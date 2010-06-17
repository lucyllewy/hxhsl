package hsl.avm2.plugins;
import flash.display.Loader;
import flash.events.Event;
import flash.events.HTTPStatusEvent;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import hsl.avm2.translation.DatalessTranslator;
import hsl.avm2.translation.error.ErrorMessageTranslator;
import hsl.avm2.translation.progress.LoadProgressTranslator;
import hsl.avm2.translation.web.HTTPStatusTranslator;
import hsl.avm2.translation.web.ReceivedDataTranslator;
import hsl.haxe.data.progress.LoadProgress;
import hsl.haxe.data.web.HTTPStatus;
import hsl.haxe.Signaler;

class LoaderShortcuts {
	private static var signalerVault:AVM2SignalerVault;
	private static function createDatalessTranslator<Datatype>():DatalessTranslator<Datatype> {
		return new DatalessTranslator<Datatype>();
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
	 * Gets a signaler that dispatches signals after all the received data is decoded. This method either creates a new signaler,
	 * or uses an existing one, depending on whether this method has been called before. If you call this method twice on the
	 * same object, the same signaler instance will be returned.
	 */
	public static inline function getCompletedSignaler(loader:Loader):Signaler<Void> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(loader.contentLoaderInfo, Event.COMPLETE, createDatalessTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when data is received as the download operation progresses. This method either
	 * creates a new signaler, or uses an existing one, depending on whether this method has been called before. If you call this
	 * method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getDataReceivedSignaler(loader:Loader):Signaler<LoadProgress> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(loader.contentLoaderInfo, ProgressEvent.PROGRESS, createLoadProgressTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when an HTTP status is received. The dispatched signals contain the HTTP status.
	 * This method either creates a new signaler, or uses an existing one, depending on whether this method has been called
	 * before. If you call this method twice on the same object, the same signaler instance will be returned.
	 */
	public static inline function getHTTPStatusReceivedSignaler(loader:Loader):Signaler<HTTPStatus> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(loader.contentLoaderInfo, HTTPStatusEvent.HTTP_STATUS, createHTTPStatusTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when a download operation results in a fatal error that terminates the download.
	 * The dispatched signals contain the related error message. This method either creates a new signaler, or uses an existing
	 * one, depending on whether this method has been called before. If you call this method twice on the same object, the same
	 * signaler instance will be returned.
	 */
	public static inline function getIOErrorOccurredSignaler(loader:Loader):Signaler<String> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(loader.contentLoaderInfo, IOErrorEvent.IO_ERROR, createErrorMessageTranslator);
	}
	/**
	 * Gets a signaler that dispatches signals when a download operation attempts to download data from a server outside the
	 * security sandbox. The dispatched signals contain the related error message. This method either creates a new signaler, or
	 * uses an existing one, depending on whether this method has been called before. If you call this method twice on the same
	 * object, the same signaler instance will be returned.
	 */
	public static inline function getSecurityErrorOccurredSignaler(loader:Loader):Signaler<String> {
		if (null == signalerVault) {
			signalerVault = new AVM2SignalerVault();
		}
		return signalerVault.getSignaler(loader.contentLoaderInfo, SecurityErrorEvent.SECURITY_ERROR, createErrorMessageTranslator);
	}
}
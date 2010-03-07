/**
 * Copyright (c) 2009-2010, The HSL Contributors. Most notable contributors, in order of appearance: Pimm Hogeling, Edo Rivai,
 * Owen Durni, Niel Drummond.
 *
 * This file is part of HSL. HSL, pronounced "hustle", stands for haXe Signaling Library.
 *
 * HSL is free software. Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *
 *   * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
 *     disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HSL CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE HSL
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * End of conditions.
 * 
 * The license of HSL might change in the near future, most likely to match the license of the haXe core libraries.
 */
package org.hsl.avm2.translation.http;

/**
 * A HTTP status. See http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information.
 */
class HTTPStatus {
	/**
	 * The class of the HTTP status. The class is determined by the first digit of the HTTP status code.
	 */
	public var statusClass(getStatusClass, null):HTTPStatusClass;
	/**
	 * The status code of the HTTP status.
	 */
	public var statusCode(default, null):Int;
	/**
	 * Creates a new HTTP status.
	 */
	public function new(statusCode:Int):Void {
		this.statusCode = statusCode;
	}
	// We're using a getter here, because we expect this property will not be accessed often.
	private inline function getStatusClass():HTTPStatusClass {
		switch (Math.floor(statusCode * .01)) {
			case 1:
			return HTTPStatusClass.informational;
			case 2:
			return HTTPStatusClass.successful;
			case 3:
			return HTTPStatusClass.redirection;
			case 4:
			return HTTPStatusClass.clientError;
			case 5:
			return HTTPStatusClass.serverError;
			default:
			return HTTPStatusClass.unknown;
		}
	}
	#if debug
	private function toString():String {
		return "[HTTPStatus statusClass=" + statusClass + " statusCode=" + statusCode + "]";
	}
	#end
}
/**
 * The class of a HTTP status. The class is determined by the first digit of the HTTP status code. See
 * http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html for more information.
 */
enum HTTPStatusClass {
	/**
	 * This class of status code indicates a provisional response, consisting only of the Status-Line and optional headers, and
	 * is terminated by an empty line.
	 */
	informational;
	/**
	 * This class of status code indicates that the client's request was successfully received, understood, and accepted.
	 */
	successful;
	/**
	 * This class of status code indicates that further action needs to be taken by the user agent in order to fulfill the
	 * request.
	 */
	redirection;
	/**
	 * This class of status code is intended for cases in which the client seems to have erred.
	 */
	clientError;
	/**
	 * This class of status code indicates that the server is aware that it has erred or is incapable of performing the request.
	 */
	serverError;
	/**
	 * This class of status code is preserved for unknown status codes.
	 */
	unknown;
}
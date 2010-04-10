/**
 * Copyright (c) 2009-2010, The HSL Contributors.
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
package hsl.haxe.direct;
import haxe.PosInfos;
import hsl.haxe.Subject;

/**
 * A direct signaler is used by subjects that directly dispatch their signals. This class serves as a base class for the
 * DirectSignaler, BigDirectSignaler and HugeDirectSignaler classes.
 */
class DirectSignalerBase {
	private var rejectNullData:Bool;
	public var subject(default, null):Subject;
	/**
	 * The fully qualified class names of the subject.
	 */
	private var subjectClassNames(getSubjectClassNames, #if as3 setSubjectClassNames #else null #end):List<String>;
	/**
	 * Creates a new direct signaler base. As this is a base class, this constructor will probably not be called outside of the
	 * library itself.
	 */
	public function new(subject:Subject, rejectNullData:Bool):Void {
		// If the passed subject is null, throw an exception. Having null for a subject might produce null object reference errors
		// later on: when the listeners use the produced signals.
		if (subject == null) {
			// TODO: throw a more exception instead of this lame one.
			throw "The subject argument must be non-null.";
		}
		this.subject = subject;
		this.rejectNullData = rejectNullData;
	}
	/**
	 * Returns the passed origin if it is not null. Returns the subject of this signaler if the passed origin is null.
	 */
	private inline function getOrigin(origin:Subject):Subject {
		return
			if (origin == null) {
				subject;
			} else {
				origin;
			}
	}
	/**
	 * Gets the fully qualified class names of the subject.
	 */
	private inline function getSubjectClassNames():List<String> {
		// As both the code below can be quite expensive, only execute it the first time the subjectClassNames property is got and
		// store the result. Use the stored result from that point on.
		if (subjectClassNames == null) {
			subjectClassNames = new List<String>();
			// Retrieve the most derived class of the subject.
			var subjectClass:Class<Dynamic> =
				// If the subject is a class, use the class. This makes static signalers possible. Thanks Cauê Waneck for pointing this
				// out.
				untyped if (Std.is(subject, Class)) {
					subject;
				// If the subject is an instance of a class, use the class the subject is an instance of.
				} else {
					Type.getClass(subject);
				}
			// Store the names of all the classes of the subject, so including super classes. Thanks to Justin Mills for pointing
			// this out.
			while (subjectClass != null) {
				subjectClassNames.add(Type.getClassName(subjectClass));
				subjectClass = Type.getSuperClass(subjectClass);
			}
		}
		return subjectClassNames;
	}
	// Because of a bug in the haXe compiler version 2.05, this method is needed when compiling to AS3. This has been fixed, but
	// the latest official build of the compiler still has this bug. This method could be removed if a new official build of the
	// haXe compiler is released. For more information, see http://code.google.com/p/haxe/issues/detail?id=47
	#if as3
	private function setSubjectClassNames(value:List<String>):List<String> {
		return subjectClassNames = value;
	}
	#end
	/**
	 * Checks whether the class name inside the passed position information equals the class name of the subject of this
	 * signaler. Used in the dispatch method, as that method may only be called by the subject.
	 * 
	 * Two notes.
	 * One, by using this method you check whether the caller is of the same type as the subject, which does not necessarily mean
	 * it's the same instance. This is the expected behavior, as it is consistent with private members.
	 * Two, one could hack his or her way around this check. How to do this should be obvious. The check is not designed to be
	 * unhackable; rather it is designed to prevent developers from accidentally misapplying HSL. Nicolas Cannasse once said
	 * "everything should be made accessible, if you know what you're doing".
	 */
	private function verifyCaller(positionInformation:PosInfos):Void {
		for (subjectClassName in subjectClassNames) {
			if (subjectClassName == positionInformation.className) {
				return;
			}
		}
		// TODO: throw a more exception instead of this lame one.
		throw "This method may only be called by the subject of the signaler.";
	}
	/**
	 * Verifies the passed data using the data verifier of the signaler, and throws an expection if the passed data does not pass
	 * the verification.
	 */
	private inline function verifyData(data:Dynamic):Void {
		if (rejectNullData && data == null) {
			// TODO: throw a more exception instead of this lame one.
			throw "Some data that was passed is null, but this signaler has been set to reject null data.";
		}
	}
}
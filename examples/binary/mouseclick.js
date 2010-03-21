$estr = function() { return js.Boot.__string_rec(this,''); }
if(typeof org=='undefined') org = {}
if(!org.hsl) org.hsl = {}
if(!org.hsl.haxe) org.hsl.haxe = {}
if(!org.hsl.haxe.translation) org.hsl.haxe.translation = {}
org.hsl.haxe.translation.Translator = function() { }
org.hsl.haxe.translation.Translator.__name__ = ["org","hsl","haxe","translation","Translator"];
org.hsl.haxe.translation.Translator.prototype.translate = null;
org.hsl.haxe.translation.Translator.prototype.__class__ = org.hsl.haxe.translation.Translator;
if(!org.hsl.js) org.hsl.js = {}
if(!org.hsl.js.translation) org.hsl.js.translation = {}
if(!org.hsl.js.translation.mouse) org.hsl.js.translation.mouse = {}
org.hsl.js.translation.mouse.ButtonState = { __ename__ : ["org","hsl","js","translation","mouse","ButtonState"], __constructs__ : ["NONE","LEFT","MIDDLE","RIGHT"] }
org.hsl.js.translation.mouse.ButtonState.LEFT = ["LEFT",1];
org.hsl.js.translation.mouse.ButtonState.LEFT.toString = $estr;
org.hsl.js.translation.mouse.ButtonState.LEFT.__enum__ = org.hsl.js.translation.mouse.ButtonState;
org.hsl.js.translation.mouse.ButtonState.MIDDLE = ["MIDDLE",2];
org.hsl.js.translation.mouse.ButtonState.MIDDLE.toString = $estr;
org.hsl.js.translation.mouse.ButtonState.MIDDLE.__enum__ = org.hsl.js.translation.mouse.ButtonState;
org.hsl.js.translation.mouse.ButtonState.NONE = ["NONE",0];
org.hsl.js.translation.mouse.ButtonState.NONE.toString = $estr;
org.hsl.js.translation.mouse.ButtonState.NONE.__enum__ = org.hsl.js.translation.mouse.ButtonState;
org.hsl.js.translation.mouse.ButtonState.RIGHT = ["RIGHT",3];
org.hsl.js.translation.mouse.ButtonState.RIGHT.toString = $estr;
org.hsl.js.translation.mouse.ButtonState.RIGHT.__enum__ = org.hsl.js.translation.mouse.ButtonState;
org.hsl.js.translation.JSCommonTranslator = function() { }
org.hsl.js.translation.JSCommonTranslator.__name__ = ["org","hsl","js","translation","JSCommonTranslator"];
org.hsl.js.translation.JSCommonTranslator.prototype.getEvent = function(nativeEvent) {
	if(nativeEvent == null) nativeEvent = window.event;
	return nativeEvent;
}
org.hsl.js.translation.JSCommonTranslator.prototype.localMouseLocationFromDOMEvent = function(event,target) {
	var ieEvent = event;
	var posx = 0;
	var posy = 0;
	if(ieEvent.pageX != null || ieEvent.pageY != null) {
		posx = ieEvent.pageX;
		posy = ieEvent.pageY;
	}
	else if(ieEvent.clientX != null || ieEvent.clientY != null) {
		posx = ieEvent.clientX + js.Lib.document.body.scrollLeft;
		posy = ieEvent.clientY + js.Lib.document.body.scrollTop;
	}
	var localx = 0;
	var localy = 0;
	if(ieEvent.offsetX != null || ieEvent.offsetY != null) {
		localx = ieEvent.offsetX;
		localy = ieEvent.offsetY;
	}
	else if(Reflect.field(ieEvent,"layerX") != null || Reflect.field(ieEvent,"layerY") != null) {
		localx = Reflect.field(ieEvent,"layerX");
		localy = Reflect.field(ieEvent,"layerY");
	}
	return new org.hsl.js.translation.mouse.LocalMouseLocation(localx,localy,target,new org.hsl.js.translation.mouse.MouseLocation(posx,posy));
}
org.hsl.js.translation.JSCommonTranslator.prototype.targetFromDOMEvent = function(event) {
	var ieEvent = event;
	var target = null;
	if(ieEvent.target != null) target = ieEvent.target;
	else if(ieEvent.srcElement != null) target = ieEvent.srcElement;
	if(target.nodeType == 3) target = target.parentNode;
	return target;
}
org.hsl.js.translation.JSCommonTranslator.prototype.__class__ = org.hsl.js.translation.JSCommonTranslator;
org.hsl.js.translation.mouse.MouseClickTranslator = function(p) { if( p === $_ ) return; {
	null;
}}
org.hsl.js.translation.mouse.MouseClickTranslator.__name__ = ["org","hsl","js","translation","mouse","MouseClickTranslator"];
org.hsl.js.translation.mouse.MouseClickTranslator.__super__ = org.hsl.js.translation.JSCommonTranslator;
for(var k in org.hsl.js.translation.JSCommonTranslator.prototype ) org.hsl.js.translation.mouse.MouseClickTranslator.prototype[k] = org.hsl.js.translation.JSCommonTranslator.prototype[k];
org.hsl.js.translation.mouse.MouseClickTranslator.prototype.translate = function(nativeEvent) {
	var mouseEvent = this.getEvent(nativeEvent);
	var target = this.targetFromDOMEvent(nativeEvent);
	var state = (mouseEvent.which == null?(function($this) {
		var $r;
		switch(mouseEvent.button) {
		case 0:{
			$r = org.hsl.js.translation.mouse.ButtonState.NONE;
		}break;
		case 1:{
			$r = org.hsl.js.translation.mouse.ButtonState.LEFT;
		}break;
		case 2:{
			$r = org.hsl.js.translation.mouse.ButtonState.RIGHT;
		}break;
		case 4:{
			$r = org.hsl.js.translation.mouse.ButtonState.MIDDLE;
		}break;
		default:{
			$r = null;
		}break;
		}
		return $r;
	}(this)):(function($this) {
		var $r;
		switch(mouseEvent.which) {
		case 1:{
			$r = org.hsl.js.translation.mouse.ButtonState.LEFT;
		}break;
		case 2:{
			$r = org.hsl.js.translation.mouse.ButtonState.MIDDLE;
		}break;
		case 3:{
			$r = org.hsl.js.translation.mouse.ButtonState.RIGHT;
		}break;
		default:{
			$r = null;
		}break;
		}
		return $r;
	}(this)));
	return new org.hsl.haxe.translation.Translation(state,target);
}
org.hsl.js.translation.mouse.MouseClickTranslator.prototype.__class__ = org.hsl.js.translation.mouse.MouseClickTranslator;
org.hsl.js.translation.mouse.MouseClickTranslator.__interfaces__ = [org.hsl.haxe.translation.Translator];
org.hsl.haxe.Slot = function() { }
org.hsl.haxe.Slot.__name__ = ["org","hsl","haxe","Slot"];
org.hsl.haxe.Slot.prototype.call = null;
org.hsl.haxe.Slot.prototype.destroy = null;
org.hsl.haxe.Slot.prototype.halt = null;
org.hsl.haxe.Slot.prototype.halted = null;
org.hsl.haxe.Slot.prototype.resume = null;
org.hsl.haxe.Slot.prototype.__class__ = org.hsl.haxe.Slot;
if(!org.hsl.haxe.direct) org.hsl.haxe.direct = {}
org.hsl.haxe.direct.LinkedSlot = function(p) { if( p === $_ ) return; {
	this.destroyed = false;
	this.halted = false;
}}
org.hsl.haxe.direct.LinkedSlot.__name__ = ["org","hsl","haxe","direct","LinkedSlot"];
org.hsl.haxe.direct.LinkedSlot.prototype.call = function(data,currentSubject,initialSubject,slotCallStatus) {
	null;
}
org.hsl.haxe.direct.LinkedSlot.prototype.destroy = function() {
	if(this.destroyed) {
		return;
	}
	this.previous.next = this.next;
	this.next.previous = this.previous;
	this.destroyed = true;
}
org.hsl.haxe.direct.LinkedSlot.prototype.destroyed = null;
org.hsl.haxe.direct.LinkedSlot.prototype.determineEquality = function(slot) {
	return false;
}
org.hsl.haxe.direct.LinkedSlot.prototype.halt = function() {
	this.halted = true;
}
org.hsl.haxe.direct.LinkedSlot.prototype.halted = null;
org.hsl.haxe.direct.LinkedSlot.prototype.next = null;
org.hsl.haxe.direct.LinkedSlot.prototype.previous = null;
org.hsl.haxe.direct.LinkedSlot.prototype.resume = function() {
	this.halted = false;
}
org.hsl.haxe.direct.LinkedSlot.prototype.__class__ = org.hsl.haxe.direct.LinkedSlot;
org.hsl.haxe.direct.LinkedSlot.__interfaces__ = [org.hsl.haxe.Slot];
org.hsl.haxe.direct.NiladicSlot = function(method) { if( method === $_ ) return; {
	org.hsl.haxe.direct.LinkedSlot.apply(this,[]);
	this.method = method;
}}
org.hsl.haxe.direct.NiladicSlot.__name__ = ["org","hsl","haxe","direct","NiladicSlot"];
org.hsl.haxe.direct.NiladicSlot.__super__ = org.hsl.haxe.direct.LinkedSlot;
for(var k in org.hsl.haxe.direct.LinkedSlot.prototype ) org.hsl.haxe.direct.NiladicSlot.prototype[k] = org.hsl.haxe.direct.LinkedSlot.prototype[k];
org.hsl.haxe.direct.NiladicSlot.prototype.call = function(data,currentSubject,initialSubject,slotCallStatus) {
	if(this.halted == false) {
		this.method();
	}
}
org.hsl.haxe.direct.NiladicSlot.prototype.determineEquality = function(slot) {
	return Std["is"](slot,org.hsl.haxe.direct.NiladicSlot) && Reflect.compareMethods((slot).method,this.method);
}
org.hsl.haxe.direct.NiladicSlot.prototype.method = null;
org.hsl.haxe.direct.NiladicSlot.prototype.__class__ = org.hsl.haxe.direct.NiladicSlot;
org.hsl.haxe.direct.RegularSlot = function(method) { if( method === $_ ) return; {
	org.hsl.haxe.direct.LinkedSlot.apply(this,[]);
	this.method = method;
}}
org.hsl.haxe.direct.RegularSlot.__name__ = ["org","hsl","haxe","direct","RegularSlot"];
org.hsl.haxe.direct.RegularSlot.__super__ = org.hsl.haxe.direct.LinkedSlot;
for(var k in org.hsl.haxe.direct.LinkedSlot.prototype ) org.hsl.haxe.direct.RegularSlot.prototype[k] = org.hsl.haxe.direct.LinkedSlot.prototype[k];
org.hsl.haxe.direct.RegularSlot.prototype.call = function(data,currentSubject,initialSubject,slotCallStatus) {
	if(this.halted) {
		return;
	}
	var signal = new org.hsl.haxe.Signal(data,this,currentSubject,initialSubject);
	this.method(signal);
	if(signal.bubblingStopped) {
		slotCallStatus.bubblingStopped = true;
	}
	if(signal.propagationStopped) {
		slotCallStatus.propagationStopped = true;
	}
}
org.hsl.haxe.direct.RegularSlot.prototype.determineEquality = function(slot) {
	return Std["is"](slot,org.hsl.haxe.direct.RegularSlot) && Reflect.compareMethods((slot).method,this.method);
}
org.hsl.haxe.direct.RegularSlot.prototype.method = null;
org.hsl.haxe.direct.RegularSlot.prototype.__class__ = org.hsl.haxe.direct.RegularSlot;
Reflect = function() { }
Reflect.__name__ = ["Reflect"];
Reflect.hasField = function(o,field) {
	if(o.hasOwnProperty != null) return o.hasOwnProperty(field);
	var arr = Reflect.fields(o);
	{ var $it0 = arr.iterator();
	while( $it0.hasNext() ) { var t = $it0.next();
	if(t == field) return true;
	}}
	return false;
}
Reflect.field = function(o,field) {
	var v = null;
	try {
		v = o[field];
	}
	catch( $e1 ) {
		{
			var e = $e1;
			null;
		}
	}
	return v;
}
Reflect.setField = function(o,field,value) {
	o[field] = value;
}
Reflect.callMethod = function(o,func,args) {
	return func.apply(o,args);
}
Reflect.fields = function(o) {
	if(o == null) return new Array();
	var a = new Array();
	if(o.hasOwnProperty) {
		
					for(var i in o)
						if( o.hasOwnProperty(i) )
							a.push(i);
				;
	}
	else {
		var t;
		try {
			t = o.__proto__;
		}
		catch( $e2 ) {
			{
				var e = $e2;
				{
					t = null;
				}
			}
		}
		if(t != null) o.__proto__ = null;
		
					for(var i in o)
						if( i != "__proto__" )
							a.push(i);
				;
		if(t != null) o.__proto__ = t;
	}
	return a;
}
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && f.__name__ == null;
}
Reflect.compare = function(a,b) {
	return ((a == b)?0:((((a) > (b))?1:-1)));
}
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
}
Reflect.isObject = function(v) {
	if(v == null) return false;
	var t = typeof(v);
	return (t == "string" || (t == "object" && !v.__enum__) || (t == "function" && v.__name__ != null));
}
Reflect.deleteField = function(o,f) {
	if(!Reflect.hasField(o,f)) return false;
	delete(o[f]);
	return true;
}
Reflect.copy = function(o) {
	var o2 = { }
	{
		var _g = 0, _g1 = Reflect.fields(o);
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			o2[f] = Reflect.field(o,f);
		}
	}
	return o2;
}
Reflect.makeVarArgs = function(f) {
	return function() {
		var a = new Array();
		{
			var _g1 = 0, _g = arguments.length;
			while(_g1 < _g) {
				var i = _g1++;
				a.push(arguments[i]);
			}
		}
		return f(a);
	}
}
Reflect.prototype.__class__ = Reflect;
org.hsl.haxe.Signaler = function() { }
org.hsl.haxe.Signaler.__name__ = ["org","hsl","haxe","Signaler"];
org.hsl.haxe.Signaler.prototype.addBubblingTarget = null;
org.hsl.haxe.Signaler.prototype.addNiladicSlot = null;
org.hsl.haxe.Signaler.prototype.addSimpleSlot = null;
org.hsl.haxe.Signaler.prototype.addSlot = null;
org.hsl.haxe.Signaler.prototype.dispatch = null;
org.hsl.haxe.Signaler.prototype.getHasSlots = null;
org.hsl.haxe.Signaler.prototype.hasSlots = null;
org.hsl.haxe.Signaler.prototype.removeBubblingTarget = null;
org.hsl.haxe.Signaler.prototype.removeNiladicSlot = null;
org.hsl.haxe.Signaler.prototype.removeSimpleSlot = null;
org.hsl.haxe.Signaler.prototype.removeSlot = null;
org.hsl.haxe.Signaler.prototype.subject = null;
org.hsl.haxe.Signaler.prototype.__class__ = org.hsl.haxe.Signaler;
StringBuf = function(p) { if( p === $_ ) return; {
	this.b = new Array();
}}
StringBuf.__name__ = ["StringBuf"];
StringBuf.prototype.add = function(x) {
	this.b[this.b.length] = x;
}
StringBuf.prototype.addChar = function(c) {
	this.b[this.b.length] = String.fromCharCode(c);
}
StringBuf.prototype.addSub = function(s,pos,len) {
	this.b[this.b.length] = s.substr(pos,len);
}
StringBuf.prototype.b = null;
StringBuf.prototype.toString = function() {
	return this.b.join("");
}
StringBuf.prototype.__class__ = StringBuf;
org.hsl.haxe.translation.Translation = function(data,initialSubject) { if( data === $_ ) return; {
	this.data = data;
	this.initialSubject = initialSubject;
}}
org.hsl.haxe.translation.Translation.__name__ = ["org","hsl","haxe","translation","Translation"];
org.hsl.haxe.translation.Translation.prototype.data = null;
org.hsl.haxe.translation.Translation.prototype.initialSubject = null;
org.hsl.haxe.translation.Translation.prototype.__class__ = org.hsl.haxe.translation.Translation;
org.hsl.haxe.direct.DirectSignaler = function(subject,rejectNullData) { if( subject === $_ ) return; {
	if(subject == null) {
		throw "The subject argument must be non-null.";
	}
	this.subject = subject;
	this.dataVerifier = (rejectNullData?new org.hsl.haxe.verification.NonNullAcceptingVerifier():new org.hsl.haxe.verification.AllAcceptingVerifier());
	this.bubblingTargets = new List();
	this.sentinel = new org.hsl.haxe.direct._DirectSignaler.Sentinel();
}}
org.hsl.haxe.direct.DirectSignaler.__name__ = ["org","hsl","haxe","direct","DirectSignaler"];
org.hsl.haxe.direct.DirectSignaler.prototype.addBubblingTarget = function(value) {
	this.bubblingTargets.add(value);
}
org.hsl.haxe.direct.DirectSignaler.prototype.addNiladicSlot = function(method) {
	return this.sentinel.add(new org.hsl.haxe.direct.NiladicSlot(method));
}
org.hsl.haxe.direct.DirectSignaler.prototype.addSimpleSlot = function(method) {
	return this.sentinel.add(new org.hsl.haxe.direct.SimpleSlot(method));
}
org.hsl.haxe.direct.DirectSignaler.prototype.addSlot = function(method) {
	return this.sentinel.add(new org.hsl.haxe.direct.RegularSlot(method));
}
org.hsl.haxe.direct.DirectSignaler.prototype.bubble = function(data,initialSubject) {
	{ var $it3 = this.bubblingTargets.iterator();
	while( $it3.hasNext() ) { var target = $it3.next();
	{
		target.dispatch(data,initialSubject,{ fileName : "DirectSignaler.hx", lineNumber : 105, className : "org.hsl.haxe.direct.DirectSignaler", methodName : "bubble"});
	}
	}}
}
org.hsl.haxe.direct.DirectSignaler.prototype.bubblingTargets = null;
org.hsl.haxe.direct.DirectSignaler.prototype.dataVerifier = null;
org.hsl.haxe.direct.DirectSignaler.prototype.dispatch = function(data,initialSubject,positionInformation) {
	if(positionInformation.methodName != "bubble" && positionInformation.className != (this.subjectClassName == null?this.subjectClassName = Type.getClassName((Std["is"](this.subject,Class)?this.subject:Type.getClass(this.subject))):this.subjectClassName)) {
		throw "The dispatch method may only be called by the subject.";
	}
	this.verifyData(data);
	var initialSubject1 = (initialSubject == null?this.subject:initialSubject);
	var status = this.dispatchUnsafe(data,initialSubject1);
	if(status.propagationStopped == false && status.bubblingStopped == false) {
		this.bubble(data,initialSubject1);
	}
}
org.hsl.haxe.direct.DirectSignaler.prototype.dispatchUnsafe = function(data,initialSubject) {
	var status = new org.hsl.haxe.direct.SlotCallStatus();
	this.sentinel.callConnected(data,this.subject,initialSubject,status);
	return status;
}
org.hsl.haxe.direct.DirectSignaler.prototype.getHasSlots = function() {
	return this.sentinel.getIsConnected();
}
org.hsl.haxe.direct.DirectSignaler.prototype.getSubjectClassName = function() {
	return (this.subjectClassName == null?this.subjectClassName = Type.getClassName((Std["is"](this.subject,Class)?this.subject:Type.getClass(this.subject))):this.subjectClassName);
}
org.hsl.haxe.direct.DirectSignaler.prototype.hasSlots = null;
org.hsl.haxe.direct.DirectSignaler.prototype.removeBubblingTarget = function(value) {
	this.bubblingTargets.remove(value);
}
org.hsl.haxe.direct.DirectSignaler.prototype.removeNiladicSlot = function(method) {
	this.sentinel.remove(new org.hsl.haxe.direct.NiladicSlot(method));
}
org.hsl.haxe.direct.DirectSignaler.prototype.removeSimpleSlot = function(method) {
	this.sentinel.remove(new org.hsl.haxe.direct.SimpleSlot(method));
}
org.hsl.haxe.direct.DirectSignaler.prototype.removeSlot = function(method) {
	this.sentinel.remove(new org.hsl.haxe.direct.RegularSlot(method));
}
org.hsl.haxe.direct.DirectSignaler.prototype.sentinel = null;
org.hsl.haxe.direct.DirectSignaler.prototype.subject = null;
org.hsl.haxe.direct.DirectSignaler.prototype.subjectClassName = null;
org.hsl.haxe.direct.DirectSignaler.prototype.verifyData = function(data) {
	var verificationResult = this.dataVerifier.verify(data);
	if(verificationResult != null) {
		throw verificationResult;
	}
}
org.hsl.haxe.direct.DirectSignaler.prototype.__class__ = org.hsl.haxe.direct.DirectSignaler;
org.hsl.haxe.direct.DirectSignaler.__interfaces__ = [org.hsl.haxe.Signaler];
org.hsl.haxe.translation.TranslatingSignaler = function(subject,translator,rejectNullData) { if( subject === $_ ) return; {
	org.hsl.haxe.direct.DirectSignaler.apply(this,[subject,rejectNullData]);
	if(translator == null) {
		throw "The translator argument must be non-null.";
	}
	this.translator = translator;
}}
org.hsl.haxe.translation.TranslatingSignaler.__name__ = ["org","hsl","haxe","translation","TranslatingSignaler"];
org.hsl.haxe.translation.TranslatingSignaler.__super__ = org.hsl.haxe.direct.DirectSignaler;
for(var k in org.hsl.haxe.direct.DirectSignaler.prototype ) org.hsl.haxe.translation.TranslatingSignaler.prototype[k] = org.hsl.haxe.direct.DirectSignaler.prototype[k];
org.hsl.haxe.translation.TranslatingSignaler.prototype.dispatchNative = function(nativeEvent) {
	var translation = this.translator.translate(nativeEvent);
	var data = translation.data;
	this.verifyData(data);
	var initialSubject = (translation.initialSubject == null?this.subject:translation.initialSubject);
	var status = this.dispatchUnsafe(data,initialSubject);
	if(status.propagationStopped == false && status.bubblingStopped == false) {
		this.bubble(data,initialSubject);
	}
}
org.hsl.haxe.translation.TranslatingSignaler.prototype.stop = function(positionInformation) {
	if(positionInformation.className != (this.subjectClassName == null?this.subjectClassName = Type.getClassName((Std["is"](this.subject,Class)?this.subject:Type.getClass(this.subject))):this.subjectClassName)) {
		throw "The stop method may only be called by the subject.";
	}
}
org.hsl.haxe.translation.TranslatingSignaler.prototype.translator = null;
org.hsl.haxe.translation.TranslatingSignaler.prototype.__class__ = org.hsl.haxe.translation.TranslatingSignaler;
org.hsl.haxe.direct.SimpleSlot = function(method) { if( method === $_ ) return; {
	org.hsl.haxe.direct.LinkedSlot.apply(this,[]);
	this.method = method;
}}
org.hsl.haxe.direct.SimpleSlot.__name__ = ["org","hsl","haxe","direct","SimpleSlot"];
org.hsl.haxe.direct.SimpleSlot.__super__ = org.hsl.haxe.direct.LinkedSlot;
for(var k in org.hsl.haxe.direct.LinkedSlot.prototype ) org.hsl.haxe.direct.SimpleSlot.prototype[k] = org.hsl.haxe.direct.LinkedSlot.prototype[k];
org.hsl.haxe.direct.SimpleSlot.prototype.call = function(data,currentSubject,initialSubject,slotCallStatus) {
	if(this.halted == false) {
		this.method(data);
	}
}
org.hsl.haxe.direct.SimpleSlot.prototype.determineEquality = function(slot) {
	return Std["is"](slot,org.hsl.haxe.direct.SimpleSlot) && Reflect.compareMethods((slot).method,this.method);
}
org.hsl.haxe.direct.SimpleSlot.prototype.method = null;
org.hsl.haxe.direct.SimpleSlot.prototype.__class__ = org.hsl.haxe.direct.SimpleSlot;
org.hsl.js.translation.mouse.MouseLocation = function(x,y) { if( x === $_ ) return; {
	this.x = x;
	this.y = y;
}}
org.hsl.js.translation.mouse.MouseLocation.__name__ = ["org","hsl","js","translation","mouse","MouseLocation"];
org.hsl.js.translation.mouse.MouseLocation.prototype.x = null;
org.hsl.js.translation.mouse.MouseLocation.prototype.y = null;
org.hsl.js.translation.mouse.MouseLocation.prototype.__class__ = org.hsl.js.translation.mouse.MouseLocation;
org.hsl.js.translation.mouse.LocalMouseLocation = function(x,y,scope,globalLocation) { if( x === $_ ) return; {
	org.hsl.js.translation.mouse.MouseLocation.apply(this,[x,y]);
	if(scope == null) {
		throw "The scope argument must be non-null.";
	}
	this.scope = scope;
	this.globalLocation = globalLocation;
}}
org.hsl.js.translation.mouse.LocalMouseLocation.__name__ = ["org","hsl","js","translation","mouse","LocalMouseLocation"];
org.hsl.js.translation.mouse.LocalMouseLocation.__super__ = org.hsl.js.translation.mouse.MouseLocation;
for(var k in org.hsl.js.translation.mouse.MouseLocation.prototype ) org.hsl.js.translation.mouse.LocalMouseLocation.prototype[k] = org.hsl.js.translation.mouse.MouseLocation.prototype[k];
org.hsl.js.translation.mouse.LocalMouseLocation.prototype.globalLocation = null;
org.hsl.js.translation.mouse.LocalMouseLocation.prototype.scope = null;
org.hsl.js.translation.mouse.LocalMouseLocation.prototype.__class__ = org.hsl.js.translation.mouse.LocalMouseLocation;
IntIter = function(min,max) { if( min === $_ ) return; {
	this.min = min;
	this.max = max;
}}
IntIter.__name__ = ["IntIter"];
IntIter.prototype.hasNext = function() {
	return this.min < this.max;
}
IntIter.prototype.max = null;
IntIter.prototype.min = null;
IntIter.prototype.next = function() {
	return this.min++;
}
IntIter.prototype.__class__ = IntIter;
if(!org.hsl.haxe.verification) org.hsl.haxe.verification = {}
org.hsl.haxe.verification.DataVerifier = function() { }
org.hsl.haxe.verification.DataVerifier.__name__ = ["org","hsl","haxe","verification","DataVerifier"];
org.hsl.haxe.verification.DataVerifier.prototype.verify = null;
org.hsl.haxe.verification.DataVerifier.prototype.__class__ = org.hsl.haxe.verification.DataVerifier;
org.hsl.js.translation.JSEventType = { __ename__ : ["org","hsl","js","translation","JSEventType"], __constructs__ : ["ERROR","PROGRESS","LOAD","UNLOAD","ABORT","CLICK","SELECT","CHANGE","SUBMIT","RESET","FOCUS","BLUR","RESIZE","SCROLL","MOUSEUP","MOUSEDOWN","MOUSEMOVE","MOUSEOVER","MOUSEOUT","MOUSEWHEEL","KEYUP","KEYDOWN"] }
org.hsl.js.translation.JSEventType.ABORT = ["ABORT",4];
org.hsl.js.translation.JSEventType.ABORT.toString = $estr;
org.hsl.js.translation.JSEventType.ABORT.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.BLUR = ["BLUR",11];
org.hsl.js.translation.JSEventType.BLUR.toString = $estr;
org.hsl.js.translation.JSEventType.BLUR.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.CHANGE = ["CHANGE",7];
org.hsl.js.translation.JSEventType.CHANGE.toString = $estr;
org.hsl.js.translation.JSEventType.CHANGE.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.CLICK = ["CLICK",5];
org.hsl.js.translation.JSEventType.CLICK.toString = $estr;
org.hsl.js.translation.JSEventType.CLICK.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.ERROR = ["ERROR",0];
org.hsl.js.translation.JSEventType.ERROR.toString = $estr;
org.hsl.js.translation.JSEventType.ERROR.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.FOCUS = ["FOCUS",10];
org.hsl.js.translation.JSEventType.FOCUS.toString = $estr;
org.hsl.js.translation.JSEventType.FOCUS.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.KEYDOWN = ["KEYDOWN",21];
org.hsl.js.translation.JSEventType.KEYDOWN.toString = $estr;
org.hsl.js.translation.JSEventType.KEYDOWN.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.KEYUP = ["KEYUP",20];
org.hsl.js.translation.JSEventType.KEYUP.toString = $estr;
org.hsl.js.translation.JSEventType.KEYUP.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.LOAD = ["LOAD",2];
org.hsl.js.translation.JSEventType.LOAD.toString = $estr;
org.hsl.js.translation.JSEventType.LOAD.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.MOUSEDOWN = ["MOUSEDOWN",15];
org.hsl.js.translation.JSEventType.MOUSEDOWN.toString = $estr;
org.hsl.js.translation.JSEventType.MOUSEDOWN.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.MOUSEMOVE = ["MOUSEMOVE",16];
org.hsl.js.translation.JSEventType.MOUSEMOVE.toString = $estr;
org.hsl.js.translation.JSEventType.MOUSEMOVE.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.MOUSEOUT = ["MOUSEOUT",18];
org.hsl.js.translation.JSEventType.MOUSEOUT.toString = $estr;
org.hsl.js.translation.JSEventType.MOUSEOUT.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.MOUSEOVER = ["MOUSEOVER",17];
org.hsl.js.translation.JSEventType.MOUSEOVER.toString = $estr;
org.hsl.js.translation.JSEventType.MOUSEOVER.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.MOUSEUP = ["MOUSEUP",14];
org.hsl.js.translation.JSEventType.MOUSEUP.toString = $estr;
org.hsl.js.translation.JSEventType.MOUSEUP.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.MOUSEWHEEL = ["MOUSEWHEEL",19];
org.hsl.js.translation.JSEventType.MOUSEWHEEL.toString = $estr;
org.hsl.js.translation.JSEventType.MOUSEWHEEL.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.PROGRESS = ["PROGRESS",1];
org.hsl.js.translation.JSEventType.PROGRESS.toString = $estr;
org.hsl.js.translation.JSEventType.PROGRESS.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.RESET = ["RESET",9];
org.hsl.js.translation.JSEventType.RESET.toString = $estr;
org.hsl.js.translation.JSEventType.RESET.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.RESIZE = ["RESIZE",12];
org.hsl.js.translation.JSEventType.RESIZE.toString = $estr;
org.hsl.js.translation.JSEventType.RESIZE.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.SCROLL = ["SCROLL",13];
org.hsl.js.translation.JSEventType.SCROLL.toString = $estr;
org.hsl.js.translation.JSEventType.SCROLL.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.SELECT = ["SELECT",6];
org.hsl.js.translation.JSEventType.SELECT.toString = $estr;
org.hsl.js.translation.JSEventType.SELECT.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.SUBMIT = ["SUBMIT",8];
org.hsl.js.translation.JSEventType.SUBMIT.toString = $estr;
org.hsl.js.translation.JSEventType.SUBMIT.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSEventType.UNLOAD = ["UNLOAD",3];
org.hsl.js.translation.JSEventType.UNLOAD.toString = $estr;
org.hsl.js.translation.JSEventType.UNLOAD.__enum__ = org.hsl.js.translation.JSEventType;
org.hsl.js.translation.JSTranslatingSignaler = function(subject,nativeDispatcher,jsEventType,translator,rejectNullData) { if( subject === $_ ) return; {
	if(translator == null) {
		translator = new org.hsl.js.translation.DatalessTranslator();
	}
	org.hsl.haxe.translation.TranslatingSignaler.apply(this,[subject,translator,rejectNullData]);
	this.nativeDispatcher = nativeDispatcher;
	this.nativeEventType = this.resolveNativeType(jsEventType);
	{
		if(nativeDispatcher.addEventListener != null) nativeDispatcher.addEventListener(this.nativeEventType.dom2,$closure(this,"dispatchNative"),false);
		else try {
			if(nativeDispatcher.attachEvent == null) nativeDispatcher[this.nativeEventType.html4] = $closure(this,"dispatchNative");
			else nativeDispatcher.attachEvent(this.nativeEventType.html4,$closure(this,"dispatchNative"));
		}
		catch( $e4 ) {
			{
				var e = $e4;
				{ }
			}
		}
	}
}}
org.hsl.js.translation.JSTranslatingSignaler.__name__ = ["org","hsl","js","translation","JSTranslatingSignaler"];
org.hsl.js.translation.JSTranslatingSignaler.__super__ = org.hsl.haxe.translation.TranslatingSignaler;
for(var k in org.hsl.haxe.translation.TranslatingSignaler.prototype ) org.hsl.js.translation.JSTranslatingSignaler.prototype[k] = org.hsl.haxe.translation.TranslatingSignaler.prototype[k];
org.hsl.js.translation.JSTranslatingSignaler.prototype.disableContextMenu = function() {
	this.nativeDispatcher.oncontextmenu = function() {
		return false;
	}
	return true;
	return false;
}
org.hsl.js.translation.JSTranslatingSignaler.prototype.nativeDispatcher = null;
org.hsl.js.translation.JSTranslatingSignaler.prototype.nativeEventType = null;
org.hsl.js.translation.JSTranslatingSignaler.prototype.resolveNativeType = function(type) {
	var $e = (type);
	switch( $e[1] ) {
	case 19:
	{
		var useDOMMouseScroll = false;
		{
			if(document.implementation.hasFeature("MouseEvents","2.0")) {
				try {
					var handle = null;
					handle = document.body.addEventListener("DOMMouseScroll",function() {
						useDOMMouseScroll = true;
						document.removeEventListener("DOMMouseScroll",handle);
					},false);
					var evt = document.createEvent("MouseScrollEvents");
					evt.initMouseEvent("DOMMouseScroll",true,true,window,0,0,0,0,0,false,false,false,false,0,null);
					document.body.dispatchEvent(evt);
				}
				catch( $e5 ) {
					{
						var e = $e5;
						{ }
					}
				}
			}
			else null;
		}
		return ((!useDOMMouseScroll)?{ html4 : "onmousewheel", dom2 : "mousewheel"}:{ html4 : "onmousewheel", dom2 : "DOMMouseScroll"});
	}break;
	case 5:
	{
		this.disableContextMenu();
		return { html4 : "onclick", dom2 : "click"}
	}break;
	case 14:
	{
		this.disableContextMenu();
		return { html4 : "onmouseup", dom2 : "mouseup"}
	}break;
	case 15:
	{
		this.disableContextMenu();
		return { html4 : "onmousedown", dom2 : "mousedown"}
	}break;
	default:{
		var name = Type.enumConstructor(type).toLowerCase();
		return { html4 : "on" + name, dom2 : name}
	}break;
	}
}
org.hsl.js.translation.JSTranslatingSignaler.prototype.stop = function(positionInformation) {
	org.hsl.haxe.translation.TranslatingSignaler.prototype.stop.apply(this,[positionInformation]);
	{
		if(this.nativeDispatcher.removeEventListener != null) this.nativeDispatcher.removeEventListener(this.nativeEventType,$closure(this,"dispatchNative"));
		else try {
			if(this.nativeDispatcher.detachEvent == null) Reflect.deleteField(this.nativeDispatcher,this.nativeEventType.html4);
			else this.nativeDispatcher.detachEvent(this.nativeEventType.html4,$closure(this,"dispatchNative"));
		}
		catch( $e6 ) {
			{
				var e = $e6;
				{ }
			}
		}
	}
}
org.hsl.js.translation.JSTranslatingSignaler.prototype.__class__ = org.hsl.js.translation.JSTranslatingSignaler;
Std = function() { }
Std.__name__ = ["Std"];
Std["is"] = function(v,t) {
	return js.Boot.__instanceof(v,t);
}
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
Std["int"] = function(x) {
	if(x < 0) return Math.ceil(x);
	return Math.floor(x);
}
Std.parseInt = function(x) {
	var v = parseInt(x);
	if(Math.isNaN(v)) return null;
	return v;
}
Std.parseFloat = function(x) {
	return parseFloat(x);
}
Std.random = function(x) {
	return Math.floor(Math.random() * x);
}
Std.prototype.__class__ = Std;
org.hsl.haxe.direct.SlotCallStatus = function(p) { if( p === $_ ) return; {
	this.bubblingStopped = false;
	this.propagationStopped = false;
}}
org.hsl.haxe.direct.SlotCallStatus.__name__ = ["org","hsl","haxe","direct","SlotCallStatus"];
org.hsl.haxe.direct.SlotCallStatus.prototype.bubblingStopped = null;
org.hsl.haxe.direct.SlotCallStatus.prototype.propagationStopped = null;
org.hsl.haxe.direct.SlotCallStatus.prototype.__class__ = org.hsl.haxe.direct.SlotCallStatus;
if(!org.hsl.haxe.direct._DirectSignaler) org.hsl.haxe.direct._DirectSignaler = {}
org.hsl.haxe.direct._DirectSignaler.Sentinel = function(p) { if( p === $_ ) return; {
	org.hsl.haxe.direct.LinkedSlot.apply(this,[]);
	this.next = this.previous = this;
}}
org.hsl.haxe.direct._DirectSignaler.Sentinel.__name__ = ["org","hsl","haxe","direct","_DirectSignaler","Sentinel"];
org.hsl.haxe.direct._DirectSignaler.Sentinel.__super__ = org.hsl.haxe.direct.LinkedSlot;
for(var k in org.hsl.haxe.direct.LinkedSlot.prototype ) org.hsl.haxe.direct._DirectSignaler.Sentinel.prototype[k] = org.hsl.haxe.direct.LinkedSlot.prototype[k];
org.hsl.haxe.direct._DirectSignaler.Sentinel.prototype.add = function(value) {
	value.next = this;
	value.previous = this.previous;
	this.previous = this.previous.next = value;
	return value;
}
org.hsl.haxe.direct._DirectSignaler.Sentinel.prototype.callConnected = function(data,currentSubject,initialSubject,slotCallStatus) {
	var node = this.next;
	while(node != this && slotCallStatus.propagationStopped == false) {
		node.call(data,currentSubject,initialSubject,slotCallStatus);
		node = node.next;
	}
}
org.hsl.haxe.direct._DirectSignaler.Sentinel.prototype.getIsConnected = function() {
	return this.next != this;
}
org.hsl.haxe.direct._DirectSignaler.Sentinel.prototype.isConnected = null;
org.hsl.haxe.direct._DirectSignaler.Sentinel.prototype.remove = function(value) {
	var node = this.next;
	while(node != this) {
		if(node.determineEquality(value)) {
			node.destroy();
			break;
		}
		node = node.next;
	}
}
org.hsl.haxe.direct._DirectSignaler.Sentinel.prototype.__class__ = org.hsl.haxe.direct._DirectSignaler.Sentinel;
org.hsl.haxe.verification.NonNullAcceptingVerifier = function(p) { if( p === $_ ) return; {
	null;
}}
org.hsl.haxe.verification.NonNullAcceptingVerifier.__name__ = ["org","hsl","haxe","verification","NonNullAcceptingVerifier"];
org.hsl.haxe.verification.NonNullAcceptingVerifier.prototype.verify = function(data) {
	return (data == null?"The passed data must be non-null":null);
}
org.hsl.haxe.verification.NonNullAcceptingVerifier.prototype.__class__ = org.hsl.haxe.verification.NonNullAcceptingVerifier;
org.hsl.haxe.verification.NonNullAcceptingVerifier.__interfaces__ = [org.hsl.haxe.verification.DataVerifier];
List = function(p) { if( p === $_ ) return; {
	this.length = 0;
}}
List.__name__ = ["List"];
List.prototype.add = function(item) {
	var x = [item];
	if(this.h == null) this.h = x;
	else this.q[1] = x;
	this.q = x;
	this.length++;
}
List.prototype.clear = function() {
	this.h = null;
	this.q = null;
	this.length = 0;
}
List.prototype.filter = function(f) {
	var l2 = new List();
	var l = this.h;
	while(l != null) {
		var v = l[0];
		l = l[1];
		if(f(v)) l2.add(v);
	}
	return l2;
}
List.prototype.first = function() {
	return (this.h == null?null:this.h[0]);
}
List.prototype.h = null;
List.prototype.isEmpty = function() {
	return (this.h == null);
}
List.prototype.iterator = function() {
	return { h : this.h, hasNext : function() {
		return (this.h != null);
	}, next : function() {
		if(this.h == null) return null;
		var x = this.h[0];
		this.h = this.h[1];
		return x;
	}}
}
List.prototype.join = function(sep) {
	var s = new StringBuf();
	var first = true;
	var l = this.h;
	while(l != null) {
		if(first) first = false;
		else s.b[s.b.length] = sep;
		s.b[s.b.length] = l[0];
		l = l[1];
	}
	return s.b.join("");
}
List.prototype.last = function() {
	return (this.q == null?null:this.q[0]);
}
List.prototype.length = null;
List.prototype.map = function(f) {
	var b = new List();
	var l = this.h;
	while(l != null) {
		var v = l[0];
		l = l[1];
		b.add(f(v));
	}
	return b;
}
List.prototype.pop = function() {
	if(this.h == null) return null;
	var x = this.h[0];
	this.h = this.h[1];
	if(this.h == null) this.q = null;
	this.length--;
	return x;
}
List.prototype.push = function(item) {
	var x = [item,this.h];
	this.h = x;
	if(this.q == null) this.q = x;
	this.length++;
}
List.prototype.q = null;
List.prototype.remove = function(v) {
	var prev = null;
	var l = this.h;
	while(l != null) {
		if(l[0] == v) {
			if(prev == null) this.h = l[1];
			else prev[1] = l[1];
			if(this.q == l) this.q = prev;
			this.length--;
			return true;
		}
		prev = l;
		l = l[1];
	}
	return false;
}
List.prototype.toString = function() {
	var s = new StringBuf();
	var first = true;
	var l = this.h;
	s.b[s.b.length] = "{";
	while(l != null) {
		if(first) first = false;
		else s.b[s.b.length] = ", ";
		s.b[s.b.length] = Std.string(l[0]);
		l = l[1];
	}
	s.b[s.b.length] = "}";
	return s.b.join("");
}
List.prototype.__class__ = List;
org.hsl.haxe.verification.AllAcceptingVerifier = function(p) { if( p === $_ ) return; {
	null;
}}
org.hsl.haxe.verification.AllAcceptingVerifier.__name__ = ["org","hsl","haxe","verification","AllAcceptingVerifier"];
org.hsl.haxe.verification.AllAcceptingVerifier.prototype.verify = function(data) {
	return null;
}
org.hsl.haxe.verification.AllAcceptingVerifier.prototype.__class__ = org.hsl.haxe.verification.AllAcceptingVerifier;
org.hsl.haxe.verification.AllAcceptingVerifier.__interfaces__ = [org.hsl.haxe.verification.DataVerifier];
ValueType = { __ename__ : ["ValueType"], __constructs__ : ["TNull","TInt","TFloat","TBool","TObject","TFunction","TClass","TEnum","TUnknown"] }
ValueType.TBool = ["TBool",3];
ValueType.TBool.toString = $estr;
ValueType.TBool.__enum__ = ValueType;
ValueType.TClass = function(c) { var $x = ["TClass",6,c]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; }
ValueType.TEnum = function(e) { var $x = ["TEnum",7,e]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; }
ValueType.TFloat = ["TFloat",2];
ValueType.TFloat.toString = $estr;
ValueType.TFloat.__enum__ = ValueType;
ValueType.TFunction = ["TFunction",5];
ValueType.TFunction.toString = $estr;
ValueType.TFunction.__enum__ = ValueType;
ValueType.TInt = ["TInt",1];
ValueType.TInt.toString = $estr;
ValueType.TInt.__enum__ = ValueType;
ValueType.TNull = ["TNull",0];
ValueType.TNull.toString = $estr;
ValueType.TNull.__enum__ = ValueType;
ValueType.TObject = ["TObject",4];
ValueType.TObject.toString = $estr;
ValueType.TObject.__enum__ = ValueType;
ValueType.TUnknown = ["TUnknown",8];
ValueType.TUnknown.toString = $estr;
ValueType.TUnknown.__enum__ = ValueType;
Type = function() { }
Type.__name__ = ["Type"];
Type.getClass = function(o) {
	if(o == null) return null;
	if(o.__enum__ != null) return null;
	return o.__class__;
}
Type.getEnum = function(o) {
	if(o == null) return null;
	return o.__enum__;
}
Type.getSuperClass = function(c) {
	return c.__super__;
}
Type.getClassName = function(c) {
	if(c == null) return null;
	var a = c.__name__;
	return a.join(".");
}
Type.getEnumName = function(e) {
	var a = e.__ename__;
	return a.join(".");
}
Type.resolveClass = function(name) {
	var cl;
	try {
		cl = eval(name);
	}
	catch( $e7 ) {
		{
			var e = $e7;
			{
				cl = null;
			}
		}
	}
	if(cl == null || cl.__name__ == null) return null;
	return cl;
}
Type.resolveEnum = function(name) {
	var e;
	try {
		e = eval(name);
	}
	catch( $e8 ) {
		{
			var err = $e8;
			{
				e = null;
			}
		}
	}
	if(e == null || e.__ename__ == null) return null;
	return e;
}
Type.createInstance = function(cl,args) {
	if(args.length <= 3) return new cl(args[0],args[1],args[2]);
	if(args.length > 8) throw "Too many arguments";
	return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
}
Type.createEmptyInstance = function(cl) {
	return new cl($_);
}
Type.createEnum = function(e,constr,params) {
	var f = Reflect.field(e,constr);
	if(f == null) throw "No such constructor " + constr;
	if(Reflect.isFunction(f)) {
		if(params == null) throw ("Constructor " + constr) + " need parameters";
		return f.apply(e,params);
	}
	if(params != null && params.length != 0) throw ("Constructor " + constr) + " does not need parameters";
	return f;
}
Type.createEnumIndex = function(e,index,params) {
	var c = Type.getEnumConstructs(e)[index];
	if(c == null) throw index + " is not a valid enum constructor index";
	return Type.createEnum(e,c,params);
}
Type.getInstanceFields = function(c) {
	var a = Reflect.fields(c.prototype);
	a.remove("__class__");
	return a;
}
Type.getClassFields = function(c) {
	var a = Reflect.fields(c);
	a.remove("__name__");
	a.remove("__interfaces__");
	a.remove("__super__");
	a.remove("prototype");
	return a;
}
Type.getEnumConstructs = function(e) {
	return e.__constructs__;
}
Type["typeof"] = function(v) {
	switch(typeof(v)) {
	case "boolean":{
		return ValueType.TBool;
	}break;
	case "string":{
		return ValueType.TClass(String);
	}break;
	case "number":{
		if(Math.ceil(v) == v % 2147483648.0) return ValueType.TInt;
		return ValueType.TFloat;
	}break;
	case "object":{
		if(v == null) return ValueType.TNull;
		var e = v.__enum__;
		if(e != null) return ValueType.TEnum(e);
		var c = v.__class__;
		if(c != null) return ValueType.TClass(c);
		return ValueType.TObject;
	}break;
	case "function":{
		if(v.__name__ != null) return ValueType.TObject;
		return ValueType.TFunction;
	}break;
	case "undefined":{
		return ValueType.TNull;
	}break;
	default:{
		return ValueType.TUnknown;
	}break;
	}
}
Type.enumEq = function(a,b) {
	if(a == b) return true;
	try {
		if(a[0] != b[0]) return false;
		{
			var _g1 = 2, _g = a.length;
			while(_g1 < _g) {
				var i = _g1++;
				if(!Type.enumEq(a[i],b[i])) return false;
			}
		}
		var e = a.__enum__;
		if(e != b.__enum__ || e == null) return false;
	}
	catch( $e9 ) {
		{
			var e = $e9;
			{
				return false;
			}
		}
	}
	return true;
}
Type.enumConstructor = function(e) {
	return e[0];
}
Type.enumParameters = function(e) {
	return e.slice(2);
}
Type.enumIndex = function(e) {
	return e[1];
}
Type.prototype.__class__ = Type;
if(typeof js=='undefined') js = {}
js.Lib = function() { }
js.Lib.__name__ = ["js","Lib"];
js.Lib.isIE = null;
js.Lib.isOpera = null;
js.Lib.document = null;
js.Lib.window = null;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
}
js.Lib.eval = function(code) {
	return eval(code);
}
js.Lib.setErrorHandler = function(f) {
	js.Lib.onerror = f;
}
js.Lib.prototype.__class__ = js.Lib;
js.Boot = function() { }
js.Boot.__name__ = ["js","Boot"];
js.Boot.__unhtml = function(s) {
	return s.split("&").join("&amp;").split("<").join("&lt;").split(">").join("&gt;");
}
js.Boot.__trace = function(v,i) {
	var msg = (i != null?((i.fileName + ":") + i.lineNumber) + ": ":"");
	msg += js.Boot.__unhtml(js.Boot.__string_rec(v,"")) + "<br/>";
	var d = document.getElementById("haxe:trace");
	if(d == null) alert("No haxe:trace element defined\n" + msg);
	else d.innerHTML += msg;
}
js.Boot.__clear_trace = function() {
	var d = document.getElementById("haxe:trace");
	if(d != null) d.innerHTML = "";
	else null;
}
js.Boot.__closure = function(o,f) {
	var m = o[f];
	if(m == null) return null;
	var f1 = function() {
		return m.apply(o,arguments);
	}
	f1.scope = o;
	f1.method = m;
	return f1;
}
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ != null || o.__ename__ != null)) t = "object";
	switch(t) {
	case "object":{
		if(o instanceof Array) {
			if(o.__enum__ != null) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				{
					var _g1 = 2, _g = o.length;
					while(_g1 < _g) {
						var i = _g1++;
						if(i != 2) str += "," + js.Boot.__string_rec(o[i],s);
						else str += js.Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			{
				var _g = 0;
				while(_g < l) {
					var i1 = _g++;
					str += ((i1 > 0?",":"")) + js.Boot.__string_rec(o[i1],s);
				}
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		}
		catch( $e10 ) {
			{
				var e = $e10;
				{
					return "???";
				}
			}
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = (o.hasOwnProperty != null);
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) continue;
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__") continue;
		if(str.length != 2) str += ", \n";
		str += ((s + k) + " : ") + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += ("\n" + s) + "}";
		return str;
	}break;
	case "function":{
		return "<function>";
	}break;
	case "string":{
		return o;
	}break;
	default:{
		return String(o);
	}break;
	}
}
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0, _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
}
js.Boot.__instanceof = function(o,cl) {
	try {
		if(o instanceof cl) {
			if(cl == Array) return (o.__enum__ == null);
			return true;
		}
		if(js.Boot.__interfLoop(o.__class__,cl)) return true;
	}
	catch( $e11 ) {
		{
			var e = $e11;
			{
				if(cl == null) return false;
			}
		}
	}
	switch(cl) {
	case Int:{
		return Math.ceil(o%2147483648.0) === o;
	}break;
	case Float:{
		return typeof(o) == "number";
	}break;
	case Bool:{
		return o === true || o === false;
	}break;
	case String:{
		return typeof(o) == "string";
	}break;
	case Dynamic:{
		return true;
	}break;
	default:{
		if(o == null) return false;
		return o.__enum__ == cl || (cl == Class && o.__name__ != null) || (cl == Enum && o.__ename__ != null);
	}break;
	}
}
js.Boot.__init = function() {
	js.Lib.isIE = (typeof document!='undefined' && document.all != null && typeof window!='undefined' && window.opera == null);
	js.Lib.isOpera = (typeof window!='undefined' && window.opera != null);
	Array.prototype.copy = Array.prototype.slice;
	Array.prototype.insert = function(i,x) {
		this.splice(i,0,x);
	}
	Array.prototype.remove = (Array.prototype.indexOf?function(obj) {
		var idx = this.indexOf(obj);
		if(idx == -1) return false;
		this.splice(idx,1);
		return true;
	}:function(obj) {
		var i = 0;
		var l = this.length;
		while(i < l) {
			if(this[i] == obj) {
				this.splice(i,1);
				return true;
			}
			i++;
		}
		return false;
	});
	Array.prototype.iterator = function() {
		return { cur : 0, arr : this, hasNext : function() {
			return this.cur < this.arr.length;
		}, next : function() {
			return this.arr[this.cur++];
		}}
	}
	var cca = String.prototype.charCodeAt;
	String.prototype.cca = cca;
	String.prototype.charCodeAt = function(i) {
		var x = cca.call(this,i);
		if(isNaN(x)) return null;
		return x;
	}
	var oldsub = String.prototype.substr;
	String.prototype.substr = function(pos,len) {
		if(pos != null && pos != 0 && len != null && len < 0) return "";
		if(len == null) len = this.length;
		if(pos < 0) {
			pos = this.length + pos;
			if(pos < 0) pos = 0;
		}
		else if(len < 0) {
			len = (this.length + len) - pos;
		}
		return oldsub.apply(this,[pos,len]);
	}
	$closure = js.Boot.__closure;
}
js.Boot.prototype.__class__ = js.Boot;
if(!org.grumpytoad) org.grumpytoad = {}
if(!org.grumpytoad.hslexample) org.grumpytoad.hslexample = {}
if(!org.grumpytoad.hslexample.mouseclick) org.grumpytoad.hslexample.mouseclick = {}
org.grumpytoad.hslexample.mouseclick.Main = function(p) { if( p === $_ ) return; {
	var result = js.Lib.document.getElementById("result");
	var locationSignaler = new org.hsl.js.translation.JSTranslatingSignaler(result,result,org.hsl.js.translation.JSEventType.MOUSEDOWN,new org.hsl.js.translation.mouse.MouseClickTranslator());
	locationSignaler.addSlot($closure(this,"onClick"));
}}
org.grumpytoad.hslexample.mouseclick.Main.__name__ = ["org","grumpytoad","hslexample","mouseclick","Main"];
org.grumpytoad.hslexample.mouseclick.Main.main = function() {
	new org.grumpytoad.hslexample.mouseclick.Main();
}
org.grumpytoad.hslexample.mouseclick.Main.prototype.onClick = function(signal) {
	var result = js.Lib.document.getElementById("result");
	result.innerHTML = "mouse button pressed: " + signal.data;
}
org.grumpytoad.hslexample.mouseclick.Main.prototype.__class__ = org.grumpytoad.hslexample.mouseclick.Main;
org.hsl.haxe.Signal = function(data,currentSlot,currentSubject,initialSubject) { if( data === $_ ) return; {
	this.data = data;
	this.currentSubject = currentSubject;
	this.currentSlot = currentSlot;
	this.initialSubject = initialSubject;
	this.bubblingStopped = false;
	this.propagationStopped = false;
}}
org.hsl.haxe.Signal.__name__ = ["org","hsl","haxe","Signal"];
org.hsl.haxe.Signal.prototype.bubblingStopped = null;
org.hsl.haxe.Signal.prototype.currentSlot = null;
org.hsl.haxe.Signal.prototype.currentSubject = null;
org.hsl.haxe.Signal.prototype.data = null;
org.hsl.haxe.Signal.prototype.initialSubject = null;
org.hsl.haxe.Signal.prototype.propagationStopped = null;
org.hsl.haxe.Signal.prototype.stopBubbling = function() {
	this.bubblingStopped = true;
}
org.hsl.haxe.Signal.prototype.stopPropagation = function() {
	this.propagationStopped = true;
}
org.hsl.haxe.Signal.prototype.__class__ = org.hsl.haxe.Signal;
org.hsl.js.translation.DatalessTranslator = function(p) { if( p === $_ ) return; {
	null;
}}
org.hsl.js.translation.DatalessTranslator.__name__ = ["org","hsl","js","translation","DatalessTranslator"];
org.hsl.js.translation.DatalessTranslator.prototype.translate = function(nativeEvent) {
	return new org.hsl.haxe.translation.Translation(null,nativeEvent.target);
}
org.hsl.js.translation.DatalessTranslator.prototype.__class__ = org.hsl.js.translation.DatalessTranslator;
org.hsl.js.translation.DatalessTranslator.__interfaces__ = [org.hsl.haxe.translation.Translator];
$Main = function() { }
$Main.__name__ = ["@Main"];
$Main.prototype.__class__ = $Main;
$_ = {}
js.Boot.__res = {}
js.Boot.__init();
{
	String.prototype.__class__ = String;
	String.__name__ = ["String"];
	Array.prototype.__class__ = Array;
	Array.__name__ = ["Array"];
	Int = { __name__ : ["Int"]}
	Dynamic = { __name__ : ["Dynamic"]}
	Float = Number;
	Float.__name__ = ["Float"];
	Bool = { __ename__ : ["Bool"]}
	Class = { __name__ : ["Class"]}
	Enum = { }
	Void = { __ename__ : ["Void"]}
}
{
	Math.NaN = Number["NaN"];
	Math.NEGATIVE_INFINITY = Number["NEGATIVE_INFINITY"];
	Math.POSITIVE_INFINITY = Number["POSITIVE_INFINITY"];
	Math.isFinite = function(i) {
		return isFinite(i);
	}
	Math.isNaN = function(i) {
		return isNaN(i);
	}
	Math.__name__ = ["Math"];
}
{
	js.Lib.document = document;
	js.Lib.window = window;
	onerror = function(msg,url,line) {
		var f = js.Lib.onerror;
		if( f == null )
			return false;
		return f(msg,[url+":"+line]);
	}
}
js.Lib.onerror = null;
$Main.init = org.grumpytoad.hslexample.mouseclick.Main.main();

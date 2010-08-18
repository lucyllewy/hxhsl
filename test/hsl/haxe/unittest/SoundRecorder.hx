package hsl.haxe.unittest;

class SoundRecorder {
	public var recordedSound(default, null):String;
	public function new():Void {
	}
	public function recordSound(value:String):Void {
		recordedSound = value;
	}
	public function reset():Void {
		recordedSound = null;
	}
}
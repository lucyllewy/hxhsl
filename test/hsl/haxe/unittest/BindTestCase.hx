package hsl.haxe.unittest;

class BindTestCase extends UnitTestCaseBase {
	private var dog:Dog;
	private var soundRecorder:SoundRecorder;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		dog = new Dog();
		soundRecorder = new SoundRecorder();
	}
	public function testBinding():Void {
		assertEquals(null, soundRecorder.recordedSound);
		dog.barkedSignaler.bind(soundRecorder.recordSound);
		assertEquals(null, soundRecorder.recordedSound);
		dog.bark();
		assertEquals(Dog.BARK, soundRecorder.recordedSound);
		soundRecorder.reset();
		assertEquals(null, soundRecorder.recordedSound);
		dog.barkedSignaler.unbind(soundRecorder.recordSound);
		assertEquals(null, soundRecorder.recordedSound);
		dog.bark();
		assertEquals(null, soundRecorder.recordedSound);
	}
}
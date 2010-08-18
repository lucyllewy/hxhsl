package hsl.haxe.unittest;

class BubbleTestCase extends UnitTestCaseBase {
	private var firstDog:Dog;
	private var secondDog:Dog;
	private var soundRecorder:SoundRecorder;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		firstDog = new Dog();
		secondDog = new Dog();
		soundRecorder = new SoundRecorder();
	}
	public function testBubbling():Void {
		assertEquals(null, soundRecorder.recordedSound);
		firstDog.barkedSignaler.addBubblingTarget(secondDog.barkedSignaler);
		secondDog.barkedSignaler.bind(soundRecorder.recordSound);
		assertEquals(null, soundRecorder.recordedSound);
		firstDog.bark();
		assertEquals(Dog.BARK, soundRecorder.recordedSound);
		soundRecorder.reset();
		assertEquals(null, soundRecorder.recordedSound);
		firstDog.barkedSignaler.removeBubblingTarget(secondDog.barkedSignaler);
		assertEquals(null, soundRecorder.recordedSound);
		firstDog.bark();
		assertEquals(null, soundRecorder.recordedSound);
	}
}
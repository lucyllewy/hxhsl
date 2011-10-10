package hsl.haxe.unittest;
import hsl.haxe.MergingSignaler;

class MergingSignalerTestCase extends UnitTestCaseBase {
	private var dog:Dog;
	private var soundRecorder:SoundRecorder;
	public function new():Void {
		super();
	}
	public override function setup():Void {
		dog = new MergingDog();
		soundRecorder = new SoundRecorder();
	}
	/**
	 * Due to the synchronous nature of haXe unit tests, this is about as much as we can test.
	 */
	public function testMerging():Void {
		assertEquals(null, soundRecorder.recordedSound);
		dog.barkedSignaler.bind(soundRecorder.recordSound);
		assertEquals(null, soundRecorder.recordedSound);
		dog.bark();
		// The sound recorder should not have recorded any sounds yet, as the merging signaler should be merging at this point.
		assertEquals(null, soundRecorder.recordedSound);
	}
}
class MergingDog extends Dog {
	public function new():Void {
		super();
		barkedSignaler = new MergingSignaler(this);
	}
}
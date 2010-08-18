package hsl.haxe.unittest;
import haxe.PosInfos;
import haxe.unit.TestCase;

class UnitTestCaseBase extends TestCase {
	public function new():Void {
		super();
	}
	/**
	 * Saves an error message if the passed values are not equal. The error message will be shown by a test runner. Does nothing
	 * if the passed values are equal. The default haXe comperator is used to compare the two values.
	 */
	public override function assertEquals<Datatype>(expectedValue:Datatype, actualValue:Datatype, ?positionInformation:PosInfos):Void {
		currentTest.done = true;
		if (actualValue != expectedValue){
			saveError(Std.string(actualValue) + " found where " + Std.string(expectedValue) + " was expected", positionInformation);
		}
	}
	/**
	 * Saves an error message if the passed value is true. The error message will be shown by a test runner. Does nothing if the
	 * passed value is false.
	 */
	public override function assertFalse(value:Bool, ?positionInformation:PosInfos):Void {
		currentTest.done = true;
		if (value) {
			saveError("true found where false was expected", positionInformation);
		}
	}
	/**
	 * Executes the passed function, and catches any thrown exceptions. Saven an error message if the execution does not throw an
	 * exception.
	 */
	public function assertThrows(value:Void -> Void, ?positionInformation:PosInfos):Void {
		currentTest.done = true;
		try {
			value();
		} catch (exception:Dynamic) {
			return;
		}
		saveError("An operation was expected to throw an exception, but this did not happen", positionInformation);
	}
	/**
	 * Saves an error message if the passed value is false. The error message will be shown by a test runner. Does nothing if the
	 * passed value is true.
	 */
	public override function assertTrue(value:Bool, ?positionInformation:PosInfos):Void {
		currentTest.done = true;
		if (false == value) {
			saveError("false found where true was expected", positionInformation);
		}
	}
	private inline function saveError(message:String, positionInformation:PosInfos):Void {
		currentTest.success = false;
		currentTest.error = message;
		currentTest.posInfos = positionInformation;
		throw currentTest;
	}
}
package hsl.haxe.speedtest;
import haxe.unit.TestRunner;

class SpeedTestRunner {
	private var testCases:List<SpeedTestCase>;
	public function new():Void {
		testCases = new List<SpeedTestCase>();
	}
	public inline function add(value:SpeedTestCase):Void {
		testCases.add(value);
	}
	private function getMircoTime():Float {
		#if flash
		return flash.Lib.getTimer();
		//#elseif php
		//return untyped __php__("microtime()");
		#else
		return Date.now().getTime();
		#end
	}
	public inline function run():Void {
		var print:Dynamic -> Void = TestRunner.print;
		for (testCase in testCases) {
			print(testCase.name);
			testCase.setup();
			var startingTime:Float = getMircoTime();
			for (iteration in 0...testCase.iterations) {
				testCase.run();
			}
			var resultingTime:Float = getMircoTime() - startingTime;
			var scientificNotationPower:Float = Math.round(100 * Math.log(testCase.iterations) / Math.log(10)) / 100;
			print(": " + testCase.iterations + " (10^" + scientificNotationPower + ") iterations in " + resultingTime + " milliseconds.\n");
			if (null != testCase.description) {
				print("(" + testCase.description + ")\n");
			}
			print("\n");
		}
	}
}
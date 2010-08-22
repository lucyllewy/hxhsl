package hsl.haxe.speedtest;

class Main {
	public static function main():Void {
		var testRunner:SpeedTestRunner = new SpeedTestRunner();
		testRunner.add(new EmptyTestCase()); // 1521 ms
		testRunner.add(new DirectSignalerInstantiationTestCase()); // 1792 ms
		testRunner.add(new DispatchTestCase()); // 1639 ms
		testRunner.add(new BindUnbindTestCase()); // 624 ms
		#if flash9
		flash.Lib.current.stage.addEventListener(flash.events.MouseEvent.CLICK, function (event:flash.events.MouseEvent) {
			testRunner.run();
		});
		#else
		testRunner.run();
		#end
	}
}
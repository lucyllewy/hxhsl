package hsl.haxe.unittest;
import haxe.unit.TestRunner;

class Main {
	public static function main():Void {
		var testRunner:TestRunner = new TestRunner();
		testRunner.add(new BindVoidTestCase());
		testRunner.add(new BindTestCase());
		testRunner.add(new BindAdvancedTestCase());
		testRunner.add(new BubbleVoidTestCase());
		testRunner.add(new BubbleTestCase());
		testRunner.add(new BubbleAdvancedTestCase());
		testRunner.add(new BondHaltTestCase());
		testRunner.add(new NotificationTestCase());
		testRunner.add(new BondDestroyTestCase());
		testRunner.add(new BondDestroyOnUseTestCase());
		testRunner.add(new IsListenedToTestCase());
		testRunner.add(new StopPropagationTestCase());
		#if !production
		testRunner.add(new IllegalDispatchTestCase());
		#end
		testRunner.add(new StaticDispatchTestCase());
		testRunner.add(new TrackableTestCase());
		#if !production
		testRunner.add(new ReadOnlyTrackableTestCase());
		#end
		testRunner.run();
	}
}

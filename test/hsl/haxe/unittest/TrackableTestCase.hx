package hsl.haxe.unittest;
import haxe.Trackable;

class TrackableTestCase extends UnitTestCaseBase {
	private var cookieMonster:CookieMonster;
	public function new():Void {
		super();
	}
	private function assertOne(value:Int):Void {
		assertEquals(1, value);
	}
	private function assertTwo(value:Int):Void {
		assertEquals(2, value);
	}
	private function assertZero(value:Int):Void {
		assertEquals(0, value);
	}
	public override function setup():Void {
		cookieMonster = new CookieMonster();
	}
	public function testTrackable():Void {
		assertEquals(0, cookieMonster.numberOfCookiesEaten.value);
		cookieMonster.numberOfCookiesEaten.changeRequestedSignaler.bind(assertZero);
		cookieMonster.numberOfCookiesEaten.changedSignaler.bind(assertOne);
		cookieMonster.eatCookie();
		cookieMonster.numberOfCookiesEaten.changeRequestedSignaler.unbind(assertZero);
		cookieMonster.numberOfCookiesEaten.changedSignaler.unbind(assertOne);
		assertEquals(1, cookieMonster.numberOfCookiesEaten.value);
		cookieMonster.numberOfCookiesEaten.changeRequestedSignaler.bind(assertOne);
		cookieMonster.numberOfCookiesEaten.changedSignaler.bind(assertTwo);
		cookieMonster.eatCookie();
		cookieMonster.numberOfCookiesEaten.changeRequestedSignaler.unbind(assertOne);
		cookieMonster.numberOfCookiesEaten.changedSignaler.unbind(assertTwo);
		assertEquals(2, cookieMonster.numberOfCookiesEaten.value);
	}
}
class CookieMonster {
	public var numberOfCookiesEaten(default, null):Trackable<Int>;
	public function new():Void {
		numberOfCookiesEaten = new Trackable(0);
	}
	public function eatCookie():Void {
		numberOfCookiesEaten.set(numberOfCookiesEaten.value + 1);
	}
}
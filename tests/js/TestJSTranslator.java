
import com.thoughtworks.selenium.SeleneseTestCase;
import com.thoughtworks.selenium.DefaultSelenium;
import java.lang.System;
import org.junit.Assert;

public class TestJSTranslator extends SeleneseTestCase {

	private String server;
	private String host;
	private String browser;
	private String path;
	private DefaultSelenium selenium;

	public void setUp() throws Exception {
		server = System.getProperty("HSL_TEST_SERVER");
		host = System.getProperty("HSL_TEST_HOST");
		browser = System.getProperty("HSL_TEST_BROWSER");
		path = System.getProperty("HSL_TEST_PATH");

		if ( server == null ) Assert.fail( "Tests must provide HSL_TEST_SERVER for a running Selenium server." );
		if ( host == null ) Assert.fail( "Tests must provide HSL_TEST_HOST for a running web server." );
		if ( path == null ) Assert.fail( "Tests must provide HSL_TEST_PATH for main test directory under the specified host." );
		if ( browser == null ) Assert.fail( "Tests must provide HSL_TEST_BROWSER for a desired browser instance." );
		selenium = new DefaultSelenium(server, 4444, browser, host);
		selenium.start();
	}
	public void tearDown() throws Exception {
		try {
			selenium.stop();
		} catch (Exception e) {}
	}

	public void testMouseCondition() throws Exception {
		selenium.open(path + "/mousecondition.html");
		selenium.waitForPageToLoad("3000");
		String prefix = "mouse location is: ";

		selenium.altKeyDown();
		selenium.mouseMoveAt( "body", "0,0" );
		assertTrue( selenium.getText("result").indexOf("alt: true, ctrl: false, shift: false") >= 0 );

		selenium.controlKeyDown();
		selenium.mouseMoveAt( "body", "0,0" );
		assertTrue( selenium.getText("result").indexOf("alt: true, ctrl: true, shift: false") >=0 );

		selenium.altKeyUp();
		selenium.controlKeyUp();

		selenium.shiftKeyDown();
		selenium.mouseMoveAt( "body", "0,0" );
		assertTrue( selenium.getText("result").indexOf("alt: false, ctrl: false, shift: true") >= 0 );
	}

	public void testHttpError() throws Exception {
		if ( browser.indexOf( "*iexplore" ) >= 0 ) return;
		selenium.open(path + "/progress.html?doerror=true");
		selenium.waitForPageToLoad("3000");
		selenium.waitForCondition( "selenium.browserbot.getCurrentWindow().xmlHttpRequest != undefined", "30000" );
		selenium.fireEvent( "dom=window.xmlHttpRequest", "error" );
		selenium.waitForCondition( "selenium.page().findElement( 'result' ).innerHTML.length > 0", "30000" );
		assertEquals( "Error code 404", selenium.getText( "result" ).substring( 0, 14) );
	}
	
	public void testComplete() throws Exception {
		if ( browser.indexOf( "*iexplore" ) >= 0 ) return;
		selenium.open(path + "/progress.html");
		selenium.waitForPageToLoad("3000");
		selenium.waitForCondition( "selenium.page().findElement( 'bar' ).innerHTML.length > 0", "30000" );
		assertTrue( selenium.isElementPresent( "xpath=//div[ @id='bar' ]/div" ) );
	}
	
	public void testKeypress() throws Exception {
		selenium.open(path + "/keypress.html");
		selenium.waitForPageToLoad("3000");
		selenium.keyUp( "result", "\101" );
		String prefix = "key pressed is: ";
		assertEquals( prefix + "A", selenium.getText( "result" ) );
		selenium.keyUp( "result", "\156" );
		assertEquals( prefix + "n", selenium.getText( "result" ) );
		selenium.keyUp( "result", "\044" );
		assertEquals( prefix + "$", selenium.getText( "result" ) );
	}

	public void testMouseClick() throws Exception {
		selenium.open(path + "/mouseclick.html");
		selenium.waitForPageToLoad("3000");
		String prefix = "mouse button pressed: ";

		selenium.waitForCondition( "selenium.page().findElement( 'result' ).innerHTML.length > 0", "30000" );
		assertEquals( prefix + "RIGHT", selenium.getText("result") );
		selenium.getEval( "this.page().findElement( 'result' ).innerHTML = '';" );

		selenium.waitForCondition( "selenium.page().findElement( 'result' ).innerHTML.length > 0", "30000" );
		assertEquals( prefix + "MIDDLE", selenium.getText("result") );
		selenium.getEval( "this.page().findElement( 'result' ).innerHTML = '';" );

		selenium.waitForCondition( "selenium.page().findElement( 'result' ).innerHTML.length > 0", "30000" );
		assertEquals( prefix + "LEFT", selenium.getText("result") );

	}


	public void testLocation() throws Exception {
		selenium.open(path + "/location.html");
		selenium.waitForPageToLoad("3000");
		selenium.waitForCondition( "selenium.page().findElement( 'result' ).innerHTML.length > 0", "30000" );
		assertTrue( selenium.getText( "result" ).matches( "x: [1-9][0-9]*, y: [1-9][0-9]*, globalX: [1-9][0-9]*, globalY: [1-9][0-9]*" ) );
	}


	public void testScroll() throws Exception {
		selenium.open(path + "/scroll.html");
		selenium.waitForPageToLoad("30000");
		String attr = selenium.getAttribute( "combine@style" );
		selenium.getEval( "this.browserbot.getCurrentWindow().g_style = this.page().findAttribute( 'combine@style'); " );
		selenium.waitForCondition( "selenium.page().findAttribute( 'combine@style') != selenium.browserbot.getCurrentWindow().g_style;", "30000" );
		assertNotEquals( attr, selenium.getAttribute( "combine@style" ) );
	}
}


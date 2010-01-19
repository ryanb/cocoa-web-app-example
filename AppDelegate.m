#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[webView setMainFrameURL:[self appURL]];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag {
	[self bringMainWindowToFront:nil];
	return YES;
}

- (IBAction)bringMainWindowToFront:(id)sender {
	[window makeKeyAndOrderFront:sender];
	if ([[webView mainFrameURL] isEqualTo:@""]) {
		[webView setMainFrameURL:[self appURL]];
	}
}

- (void)windowWillClose:(NSNotification *)notification {
	[webView setMainFrameURL:@""];
}

// Make every method in this class available to javascript
// This may be a security risk so you may want to add logic to
// restrict which methods are accessible
+ (BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector { return NO; }

// Here we grab the URL to the bundled index.html document.
// Normally it would be the URL to your web app such as @"http://example.com".
- (NSString *)appURL {
	return [[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"] absoluteString];
}


// Change the application's icon in the dock, this is triggered from JavaScript
- (void)changeIcon:(NSString *)iconName {
	[NSApp setApplicationIconImage:[NSImage imageNamed:iconName]];
}


// Changes the greeting message by executing a function in JavaScript.
// This is triggered from the Change Greeting menu item.
- (IBAction)changeGreeting:(id)sender {
	[[webView windowScriptObject] evaluateWebScript:@"changeGreeting('Hello from Objective-C!')"];
}

// This delegate method gets triggered every time the page loads, but before the JavaScript runs
- (void)webView:(WebView *)webView windowScriptObjectAvailable:(WebScriptObject *)windowScriptObject {
	// Allow this class to be usable through the "window.app" object in JavaScript
	// This could be any Objective-C class
	[windowScriptObject setValue:self forKey:@"app"];
}

@end

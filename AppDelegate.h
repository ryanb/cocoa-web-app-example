#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
	IBOutlet id webView;
	IBOutlet NSWindow *window;
}

- (IBAction)bringMainWindowToFront:(id)sender;
- (void)changeIcon:(NSString *)iconName;
- (NSString *)appURL;
- (IBAction)changeGreeting:(id)sender;

@end

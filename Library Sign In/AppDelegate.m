//
//  AppDelegate.m
//  Library Sign In
//
//  Created by Darien Craig on 5/5/16.
//  Copyright © 2016 DHS Library. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>
@interface AppDelegate ()

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webView;
@property (unsafe_unretained) IBOutlet NSView *quitPassword;
@property (unsafe_unretained) IBOutlet NSView *view;
@property (unsafe_unretained) IBOutlet NSSecureTextFieldCell *password;
@property (unsafe_unretained) IBOutlet NSSecureTextField *passBox;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSURL *url = [NSURL URLWithString:@"https://docs.google.com/a/csdecatur.net/forms/d/1Cju3DqzKBplOsXzsuQ_iS1jfKqUloPvCFovlkP1UmHY/viewform"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [[[self webView] mainFrame] loadRequest:urlRequest];
    if ([self.view isInFullScreenMode])
    {
        [self.view exitFullScreenModeWithOptions:nil];
    }
    else
    {
        [self.view enterFullScreenMode:[[self.view window] screen] withOptions:nil];
        
        for (NSView *view in [NSArray arrayWithArray:[self.view subviews]])
        {
            [view removeFromSuperview];
            [self.view addSubview:view];
        }
    }
}
- (IBAction)quitAttempt:(id)sender
{
    [self.quitPassword removeFromSuperview];
    [self.view addSubview:self.quitPassword positioned:NSWindowAbove relativeTo:nil];
    [self.quitPassword setHidden:false];
    [self.passBox becomeFirstResponder];
}
- (IBAction)quitResult:(id)sender
{
    NSString *pass = [self.password stringValue];
    if ([pass isEqual:@"guest"])
    {
        exit(0);
    }
}
- (IBAction)quitCancel:(id)sender
{
    [self.password setStringValue:@""];
    [self.quitPassword removeFromSuperview];
    [self.view addSubview:self.quitPassword positioned:NSWindowBelow relativeTo:nil];
    [self.quitPassword setHidden:true];
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

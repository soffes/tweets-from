//
//  TweetsFromAppDelegate.m
//  TweetsFrom
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright Tasteful Works 2010. All rights reserved.
//

#import "TweetsFromAppDelegate.h"
#import "RootViewController.h"


@implementation TweetsFromAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end


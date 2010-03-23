//
//  TweetsFromAppDelegate.m
//  TweetsFrom
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "TweetsFromAppDelegate.h"
#import "RootViewController.h"

@implementation TweetsFromAppDelegate

@synthesize window;
@synthesize navigationController;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIApplicationDelegate
#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}

@end

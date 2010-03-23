//
//  TweetsFromAppDelegate.h
//  TweetsFrom
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsFromAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end


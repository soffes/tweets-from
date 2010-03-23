//
//  RootViewController.m
//  TweetsFrom
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize mapView;
@synthesize statusLabel;

- (void)viewDidLoad {
	self.title = @"Tweets From";
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	[refreshButton release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


- (IBAction)refresh:(id)sender {
	statusLabel.text = @"Never updated";
}

@end

//
//  RootViewController.h
//  TweetsFrom
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RootViewController : UIViewController <MKMapViewDelegate> {
	
	MKMapView *mapView;
	UILabel *statusLabel;
	
	NSArray *tweetAnnotations;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

- (IBAction)refresh:(id)sender;

@end

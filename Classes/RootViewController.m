//
//  RootViewController.m
//  TweetsFrom
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "RootViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "SSMapAnnotation.h"

#define kTwitterUsername @"YOUR_USERNAME"
#define kTwitterPassword @"YOUR_PASSWORD"

@implementation RootViewController

@synthesize mapView;
@synthesize statusLabel;

#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[tweetAnnotations release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIViewController
#pragma mark -

- (void)viewDidLoad {
	// Title
	self.title = @"Tweets From";
	
	// Refresh botton
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
	self.navigationItem.rightBarButtonItem = refreshButton;
	[refreshButton release];
	
	// Set region
	MKCoordinateRegion region;
	region.center.latitude = 37.37;
	region.center.longitude = -96.24;
	region.span.latitudeDelta = 28.49;
	region.span.longitudeDelta = 31.025;
	[mapView setRegion:region animated:NO];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Allow any orientation except portrait upside down
	return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}


#pragma mark -
#pragma mark Actions
#pragma mark -

- (IBAction)refresh:(id)sender {
	// Update UI
	self.navigationItem.rightBarButtonItem.enabled = NO;
	statusLabel.text = @"Updating...";
	
	// Remove current notation
	[mapView removeAnnotations:tweetAnnotations];
	[tweetAnnotations release];
	
	// Start request to Twitter
	NSURL *url = [[NSURL alloc] initWithString:@"http://api.twitter.com/1/statuses/home_timeline.json?count=200"];
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
	[request setUsername:kTwitterUsername];
	[request setPassword:kTwitterPassword];
	request.delegate = self;
	[request startAsynchronous];
	[request release];
	[url release];	
}


#pragma mark -
#pragma mark MKMapViewDelegate
#pragma mark -

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *reuseIdentifier = @"pinIdentifier";
	
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
    if (pin == nil) {       
		pin = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier] autorelease];
    }
	
	// Configure pin
    pin.annotation = annotation;
	pin.animatesDrop = YES;
	pin.canShowCallout = YES;
    return pin;
}


- (void)mapViewDidFinishLoadingMap:(MKMapView *)aMapView {
	// Reload if there are no annotations
	if ([[mapView annotations] count] == 0) {
		[self refresh:nil];
	}
}


#pragma mark -
#pragma mark ASIHTTPRequest Delegate
#pragma mark -

- (void)requestFinished:(ASIHTTPRequest *)aRequest {
	// Parse response
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSString *jsonString = [[NSString alloc] initWithData:[aRequest responseData] encoding:NSUTF8StringEncoding];
	NSArray *tweets = (NSArray *)[parser objectWithString:jsonString];
	[parser release];
	[jsonString release];
	
	// Loop through tweets
	NSUInteger geoTweets = 0;
	NSMutableArray *annotations = [[NSMutableArray alloc] init];
	for (NSDictionary *tweet in tweets) {
		// Add ones with coordinates
		NSDictionary *coordinatesDictionary = [tweet objectForKey:@"coordinates"];
		if (![coordinatesDictionary isEqual:[NSNull null]]) {
			// Coordinate
			NSArray *coordinates = [coordinatesDictionary objectForKey:@"coordinates"];
			CLLocationCoordinate2D coordinate;
			coordinate.latitude = [[coordinates objectAtIndex:1] floatValue];
			coordinate.longitude = [[coordinates objectAtIndex:0] floatValue];
			
			// Create annotation
			SSMapAnnotation *annotation = [[SSMapAnnotation alloc] init];
			annotation.coordinate = coordinate;
			annotation.title = [NSString stringWithFormat:@"@%@ in %@", [[tweet objectForKey:@"user"] objectForKey:@"screen_name"], [[tweet objectForKey:@"place"] objectForKey:@"full_name"]];
			annotation.subtitle = [tweet objectForKey:@"text"];
			
			// Add annotation to map
			[mapView addAnnotation:annotation];
			[annotations addObject:annotation];
			[annotation release];
			geoTweets++;
		}
	}
	
	// Store annotations in an ivar so we can clean up later
	tweetAnnotations = [[NSArray alloc] initWithArray:annotations];
	[annotations release];
	
	// Update UI
	statusLabel.text = [NSString stringWithFormat:@"%i tweets", geoTweets];
	self.navigationItem.rightBarButtonItem.enabled = YES;
}


- (void)requestFailed:(ASIHTTPRequest *)aRequest {
	// Show error alert
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[[aRequest error] localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];

	// Update UI
	self.navigationItem.rightBarButtonItem.enabled = YES;
}

@end

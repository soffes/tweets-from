//
//  SSMapAnnotation.m
//  Public Domain
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "SSMapAnnotation.h"

@implementation SSMapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

#pragma mark -
#pragma mark Class Methods
#pragma mark -

+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate {
	return [self mapAnnotationWithCoordinate:coordinate title:nil subtitle:nil];
}


+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
	return [self mapAnnotationWithCoordinate:coordinate title:title subtitle:nil];
}


+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
	SSMapAnnotation *annotation = [[[self alloc] init] autorelease];
	annotation.coordinate = coordinate;
	annotation.title = title;
	annotation.subtitle = subtitle;
	return annotation;
}


#pragma mark -
#pragma mark NSObject
#pragma mark -

- (void)dealloc {
	[_title release];
	[_subtitle release];
	[super dealloc];
}


#pragma mark -
#pragma mark Initializers
#pragma mark -

- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
	return [self initWithCoordinate:coordinate title:nil subtitle:nil];
}


- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
	return [self initWithCoordinate:coordinate title:title subtitle:nil];
}


- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
	if (self = [super init]) {
		self.coordinate = coordinate;
		self.title = title;
		self.subtitle = subtitle;
	}
	return self;
}

@end

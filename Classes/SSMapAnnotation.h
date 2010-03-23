//
//  SSMapAnnotation.h
//  Public Domain
//
//  Created by Sam Soffes on 3/22/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface SSMapAnnotation : NSObject <MKAnnotation> {

	CLLocationCoordinate2D _coordinate;
	NSString * _title;
	NSString * _subtitle;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate;
+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
+ (SSMapAnnotation *)mapAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
- (SSMapAnnotation *)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

@end

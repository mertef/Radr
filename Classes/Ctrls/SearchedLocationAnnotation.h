//
//  SearchedLocationAnnotation.h
//  RadrApp
//
//  Created by zhangdong on 1/26/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface SearchedLocationAnnotation : NSObject<MKAnnotation> {
	@protected
	NSString* _title;
	NSString* _longTitle;
	NSString* _subTitle;
	CLLocationCoordinate2D coordinate;
}
@property(nonatomic, copy) NSString* _title, * _subTitle, *longTitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (NSString *)subtitle;
- (NSString *)title;
-(id)initWithCoordinate: (CLLocationCoordinate2D)aCoordinate title: (NSString*)aTitle subTitle: (NSString*)aSubTitle;
@end

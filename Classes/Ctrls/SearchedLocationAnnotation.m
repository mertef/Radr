//
//  SearchedLocationAnnotation.m
//  RadrApp
//
//  Created by zhangdong on 1/26/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "SearchedLocationAnnotation.h"


@implementation SearchedLocationAnnotation
@synthesize _title=title;
@synthesize  _subTitle=subtitle;
@synthesize coordinate;
@synthesize longTitle;

-(id)initWithCoordinate: (CLLocationCoordinate2D)aCoordinate title: (NSString*)aTitle subTitle: (NSString*)aSubTitle {
    if (self = [super init]) {
		_title = [aTitle copy];
		_subTitle = [aSubTitle copy];
		coordinate = aCoordinate;
	}
	return self;
}
// Title and subtitle for use by selection UI.
- (NSString *)title {
	return _title;	
}
- (NSString *)subtitle {
	return _subTitle;
}

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
   	coordinate = newCoordinate;
}

- (void) dealloc
{
	[_title release], title = nil;
	[_subTitle release], _subTitle = nil;
	[longTitle release], longTitle = nil;
	[super dealloc];
}

@end

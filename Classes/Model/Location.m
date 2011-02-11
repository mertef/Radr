//
//  Locations.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "Location.h"


@implementation Location
@synthesize long_title, place_name, title;
@synthesize center_lat, center_long;



- (void) dealloc
{
	[long_title release], long_title = nil;
	[place_name release], place_name = nil;
	[title release], title = nil;
	center_lat = 0.0f;
	center_long = 0.0f;
	[super dealloc];
}

@end

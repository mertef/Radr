//
//  MetaData.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "MetaData.h"

@implementation Data

@synthesize name, avg_price, month;
@synthesize datapoints;

- (id) init
{
	self = [super init];
	if (self != nil) {
	}
	return self;
}


- (void) dealloc
{
    [name release], name = nil;
	[avg_price release], avg_price = nil;
	[month release], month = nil;
	datapoints = 0;
	[super dealloc];
}


@end

@implementation MetaData
@synthesize data;
@synthesize currency	  ;
@synthesize listing_type	   ;
@synthesize metadata_name	  ;
@synthesize num_beds	   ;
@synthesize num_rooms	   ;
@synthesize price_type	   ;
@synthesize property_type	  ;
@synthesize url		   ;


- (id) init
{
	self = [super init];
	if (self != nil) {
		data = [[NSMutableArray alloc] initWithCapacity:24];
	}
	return self;
}

- (void) dealloc
{
	[ currency	  release] ;
	[ listing_type	  release]  ;
	[ metadata_name  release] 	  ;
	[ num_beds	  release]  ;
	[ num_rooms	  release]  ;
	[ price_type	  release]  ;
	[ property_type  release] 	  ;
	[ url		  release]  ;
	[super dealloc];
}

@end

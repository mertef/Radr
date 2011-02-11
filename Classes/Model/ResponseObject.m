//
//  ResponseObject.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "ResponseObject.h"
#import "Attribuition.h"
#import "MetaData.h"
#import "Labels.h"

@implementation ResponseObject

@synthesize attribution;
@synthesize listings;
@synthesize locations;
@synthesize metadata;
@synthesize labels;

@synthesize action		       ;
@synthesize application_response_code   ;
@synthesize application_response_text   ;
@synthesize country		       ;
@synthesize created_http		       ;
@synthesize created_unix		       ;
@synthesize encoding		       ;
@synthesize keywords		       ;
@synthesize link_to_url		       ;
@synthesize most_recent_month	       ;
@synthesize most_recent_quarter	       ;
@synthesize page			       ;
@synthesize sort			       ;
@synthesize status_code		       ;
@synthesize status_text		       ;
@synthesize thanks		       ;
@synthesize total_pages		       ;
@synthesize total_results	       ;

- (id) init
{
	self = [super init];
	if (self != nil) {
		listings = [[NSMutableArray alloc] initWithCapacity:20];
		locations = [[NSMutableArray alloc] initWithCapacity:8];
		attribution = [[Attribuition alloc] init];
		metadata = [[NSMutableArray alloc] initWithCapacity:1];
		
		labels = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return self;
}



- (void) dealloc
{
	[attribution release], attribution = nil;
	[listings release], listings = nil;
	[locations release], locations = nil;
	[metadata release], metadata = nil;
	[labels release], labels = nil;
	
	[action		     release]    ;
	[application_response_code  release]   ;
	[application_response_text  release]   ;
	[country		     release]    ;
	[created_http		     release]    ;
	created_unix = 0;
	[encoding		     release]    ;
	[keywords		     release]    ;
	[link_to_url		     release]    ;
	[most_recent_month	     release]    ;
	[most_recent_quarter	     release]    ;
	[page			     release]    ;
	[sort			     release]    ;
	[status_code		     release]    ;
	[status_text		     release]    ;
	[thanks		     release]    ;
	total_pages = 0;
	total_results = 0;
	
	[super dealloc];
}


@end

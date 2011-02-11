//
//  Listing.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "Listing.h"
#import "Config.h"

@implementation Listing
@synthesize auction_date;
@synthesize bathroom_number       ;
@synthesize bedroom_number        ;
@synthesize car_spaces			  ;
@synthesize commission			  ;
@synthesize construction_year		  ;
@synthesize datasource_name		  ;
@synthesize guid				  ;
@synthesize img_height			  ;
@synthesize img_url			  ;
@synthesize img_width			  ;
@synthesize keywords			  ;
@synthesize land_size			  ;
@synthesize land_size_unit		  ;
@synthesize latitude			  ;
@synthesize lister_name			  ;
@synthesize lister_url			  ;
@synthesize listing_type			  ;
@synthesize location_accuracy		  ;
@synthesize longitude			  ;
@synthesize price				  ;
@synthesize price_currency		  ;
@synthesize price_formatted		  ;
@synthesize price_high			  ;
@synthesize price_low			  ;
@synthesize price_type			  ;
@synthesize property_type			  ;
@synthesize room_number			  ;
@synthesize size				  ;
@synthesize size_unit			  ;
@synthesize summary			  ;
@synthesize thumb_height			  ;
@dynamic thumb_url			  ;
@synthesize thumb_width			  ;
@synthesize title				  ;
@synthesize updated_in_days		  ;
@synthesize updated_in_days_formatted	  ;
@synthesize thumb_img_data;

- (void) dealloc
{
	auction_date = 0;
	[bathroom_number release];
	[bedroom_number release];
	car_spaces	= 0;		
	commission	= 0.0f;
	construction_year = 0;
	[datasource_name		release]  ;
	[guid				release]  ;
	img_height = 0;
	[img_url			release]  ;
	img_width = 0;
	[keywords			release]  ;
	[land_size			release]  ;
	[land_size_unit		release]  ;
	latitude = 0;
	[lister_name			release]  ;
	[lister_url			release]  ;
	[listing_type			release]  ;
	location_accuracy = 0;
	longitude	= 0;
	price = 0;
	[price_currency		release]  ;
	[price_formatted		release]  ;
	price_high = 0;
	price_low = 0;
	[price_type			release]  ;
	[property_type		release]  ;
	room_number	= 0;
	[size				release]  ;
	[size_unit			release]  ;
	[summary			release]  ;
	thumb_height = 0;
	[thumb_url			release]  ;
	thumb_width	= 0;
	[title				release]  ;
	updated_in_days = 0;
	[updated_in_days_formatted	release]  ;
	[thumb_img_data release], thumb_img_data = nil;
	[super dealloc];
}

-(void)setThumbUrl: (NSString*)aUrl {
	thumb_url = [aUrl copy];
	//[NSThread detachNewThreadSelector:@selector(getImageData:) toTarget:self withObject:aUrl];
	//[self getImageData:aUrl];
}

-(void)getImageData:(id)aSender {
	@synchronized(self){
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		thumb_img_data = [NSData dataWithContentsOfURL:[NSURL URLWithString: (NSString*)aSender]];
		[thumb_img_data retain];
		[[NSNotificationCenter defaultCenter] postNotificationName:CONST_REFRESH object:nil];
		[pool release], pool = nil;
	}
}

-(void)getImageData {
		thumb_img_data = [NSData dataWithContentsOfURL:[NSURL URLWithString: thumb_url]];
		[thumb_img_data retain];
}
@end

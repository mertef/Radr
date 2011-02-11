//
//  ModelParser.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "ModelParser.h"
#import "RadrModel.h"
#import "RequestObject.h"
#import "Attribuition.h"
#import "ResponseObject.h"
#import "Listing.h"
#import "Location.h"
#import "MetaData.h"
#import "Labels.h"

@interface NSNull(Private)
-(int)intValue;
-(float)floatValue;
@end

@implementation NSNull(Private)

-(int)intValue {
	return 0;	
}
-(float)floatValue {
	return 0.0f;	
}

@end

@interface ModelParser(Private)
/*
 
 Attribuition* attribution;
 NSMutableArray* listings;
 NSMutableArray* locations;
 MetaData* metaData;
 Labels* labels;
 */
-(BOOL)consumingRequest: (NSDictionary*)aRequest;
-(BOOL)consumingResponse: (NSDictionary*)aResponse;
-(BOOL)consumingAttribution: (NSDictionary*)aAttribution;
-(BOOL)consumingListings: (NSArray*)aListings;
-(BOOL)consumingMetaData: (NSArray*)aMetaData;
-(BOOL)consumingLabels: (NSArray*)aLabels;
-(BOOL)consumingLocations: (NSArray*)aLocations;
@end


@implementation ModelParser

@synthesize model;

- (id) init
{
	self = [super init];
	if (self != nil) {
		model = [ [RadrModel alloc] init];
		
	}
	return self;
}


- (void) dealloc
{
	[model release], model = nil;
	[super dealloc];
}


-(BOOL)consumingJoson: (NSDictionary*)aJSonDictionary {
	
	BOOL flag = YES;
	if([self consumingRequest: [aJSonDictionary objectForKey:@"request"]] ) {
		[self consumingResponse:[aJSonDictionary objectForKey:@"response"]];	
	}
	return flag;
}


#pragma mark -
#pragma mark Private
-(BOOL)consumingRequest: (NSDictionary*)aRequest {
	BOOL flag = YES;
	NSLog(@"%@", aRequest);
    [aRequest retain];
	model.request.action = [aRequest objectForKey:@"action"];
	model.request.country = [aRequest objectForKey:@"country"];
	model.request.encoding = [aRequest objectForKey:@"encoding"];
	model.request.guid = [aRequest objectForKey:@"guid"];
	model.request.language = [aRequest objectForKey:@"language"];
	model.request.location = [aRequest objectForKey:@"location"];
	model.request.num_res = [[aRequest objectForKey:@"num_res"] intValue];
	model.request.offset = [[aRequest objectForKey:@"offset"] intValue];
	model.request.output = [aRequest objectForKey:@"output"];
	model.request.page = [[aRequest objectForKey:@"page"] intValue];
	model.request.product_type = [aRequest objectForKey:@"product_type"];
	model.request.property_type = [aRequest objectForKey:@"property_type"];
	model.request.listing_type = [aRequest objectForKey:@"listing_type"];
	model.request.sort = [aRequest objectForKey:@"sort"];
	[aRequest release];
	//model.request.pretty = [aRequest objectForKey:@"pretty"];
	//model.request.listing_type = [aRequest objectForKey:@"listing_type"];

	return flag;
}

-(BOOL)consumingResponse: (NSDictionary*)aResponse {
	BOOL flag = YES;
	NSDictionary* attribution = [aResponse objectForKey:@"attribution"];
	if ([self consumingAttribution:attribution]) {
		NSArray* listings = [aResponse objectForKey:@"listings"];
		if ([self consumingListings: listings]) {
			NSArray* locations = [aResponse objectForKey:@"locations"];
			if ([self consumingLocations: locations]) {
				NSArray* metaDataList = [aResponse objectForKey:@"metadata"];
				if ([self consumingMetaData:metaDataList]) {
					NSArray* labelsList = [aResponse objectForKey:@"labels"];
					if ( ! [self consumingLabels:labelsList]) {
						flag = NO;
					}
				}
			}
		}
		
	}
	model.response.action = [aResponse objectForKey:@"action"];
	model.response.application_response_code = [aResponse objectForKey:@"application_response_code"];
	model.response.application_response_text = [aResponse objectForKey:@"application_response_text"];
	model.response.country = [aResponse objectForKey:@"country"];
	model.response.created_http = [aResponse objectForKey:@"created_http"];
	model.response.created_unix = [aResponse objectForKey:@"created_unix"];
	model.response.encoding = [aResponse objectForKey:@"encoding"];
	model.response.keywords = [aResponse objectForKey:@"keywords"];
	model.response.link_to_url = [aResponse objectForKey:@"link_to_url"];
	model.response.most_recent_month = [aResponse objectForKey:@"most_recent_month"];
	model.response.most_recent_quarter = [aResponse objectForKey:@"most_recent_quarter"];
	model.response.page = [aResponse objectForKey:@"page"];
	model.response.sort = [aResponse objectForKey:@"sort"];
	model.response.status_code = [aResponse objectForKey:@"status_code"];
	model.response.status_text = [aResponse objectForKey:@"status_text"];
	model.response.thanks = [aResponse objectForKey:@"thanks"];
	model.response.total_pages = [[aResponse objectForKey:@"total_pages"] intValue];
	model.response.total_results = [[aResponse objectForKey:@"total_results"] intValue];
	
	
	return flag;
}
-(BOOL)consumingAttribution: (NSDictionary*)aAttribution {
	BOOL flag = YES;
	[aAttribution retain];
	model.response.attribution.img_height = [[aAttribution objectForKey:@"img_height" ] intValue];
	
	model.response.attribution.img_url = [aAttribution objectForKey:@"img_url" ];
	model.response.attribution.img_width = [[aAttribution objectForKey:@"img_width" ] intValue];
	model.response.attribution.link_to_img = [aAttribution objectForKey:@"link_to_img" ];
    
	[aAttribution release];
	return flag;
}
-(BOOL)consumingListings: (NSArray*)aListings {
	BOOL flag = YES;
	[aListings retain];
	for (NSDictionary* listing in aListings) {
		Listing* l = [[Listing alloc] init];
		l.auction_date = [[listing objectForKey:@"auction_date"] intValue];

		l.bathroom_number = [listing objectForKey:@"bathroom_number"];
		l.bedroom_number = [listing objectForKey:@"bedroom_number"];
		l.car_spaces = [[listing objectForKey:@"car_spaces"] intValue];
		l.commission = [[listing objectForKey:@"commission"] floatValue];
		l.construction_year = [[listing objectForKey:@"construction_year"] intValue];
		l.datasource_name = [listing objectForKey:@"datasource_name"];
		l.guid = [listing objectForKey:@"guid"];
		l.img_height = [[listing objectForKey:@"img_height"] intValue];
		l.img_url = [listing objectForKey:@"img_url"];
		l.img_width = [[listing objectForKey:@"img_width"] intValue];
		l.keywords = [listing objectForKey:@"keywords"];
		l.land_size = [listing objectForKey:@"land_size"];
		l.land_size_unit = [listing objectForKey:@"land_size_unit"];
		l.latitude = [[listing objectForKey:@"latitude"] floatValue];
		l.lister_name = [listing objectForKey:@"lister_name"];
		l.lister_url = [listing objectForKey:@"lister_url"];
		l.listing_type = [listing objectForKey:@"listing_type"];
		l.location_accuracy = [[listing objectForKey:@"location_accuracy"] intValue];
		l.longitude = [[listing objectForKey:@"longitude"] floatValue];
		l.price = [[listing objectForKey:@"price"] intValue];
		l.price_currency = [listing objectForKey:@"price_currency"];
		l.price_formatted = [listing objectForKey:@"price_formatted"];
		l.price_high = [[listing objectForKey:@"price_high"] intValue];
		l.price_low = [[listing objectForKey:@"price_low"] intValue];
		l.price_type = [listing objectForKey:@"price_type"];
		l.property_type = [listing objectForKey:@"property_type"];
		l.room_number = [[listing objectForKey:@"room_number"] intValue];
		l.size = [listing objectForKey:@"size"];
		l.size_unit = [listing objectForKey:@"size_unit"];
		l.summary = [listing objectForKey:@"summary"];
		l.thumb_height = [[listing objectForKey:@"thumb_height"] intValue];
		l.thumb_url = [listing objectForKey:@"thumb_url"];
		l.thumb_width = [[listing objectForKey:@"thumb_width"] intValue];
		l.title = [listing objectForKey:@"title"];
		l.updated_in_days = [[listing objectForKey:@"updated_in_days"] floatValue];
		l.updated_in_days_formatted = [listing objectForKey:@"updated_in_days_formatted"];
		

		[[[model response] listings] addObject: l];
		[l release], l = nil;
	}
	[aListings release];
	return flag;
}

-(BOOL)consumingLocations: (NSArray*)aLocations {
	BOOL flag = YES;
	[aLocations retain];
	for (NSDictionary* location in aLocations) {
		Location* l = [[Location alloc] init];
		l.center_lat = [[location objectForKey:@"center_lat"] floatValue];
		l.center_long = [[location objectForKey:@"center_long"] floatValue];
		l.long_title = [location objectForKey:@"long_title"];
		l.place_name = [location objectForKey:@"place_name"];
		l.title = [location objectForKey:@"title"];

		[model.response.locations addObject: l];
		[l release], l = nil;
	}
	[aLocations release];
	return flag;
}

-(BOOL)consumingMetaData: (NSArray*)aMetaData {
	BOOL flag = YES;
	[aMetaData retain];
     for (NSDictionary* meta in aMetaData) {
		 MetaData* md = [[MetaData alloc] init];
		 NSDictionary* dataList = [meta objectForKey:@"data"];
		 NSArray* keys = [dataList allKeys];
		 for (NSString* key in keys) {
			// NSLog(@"%@", key);
					
			 NSDictionary* value = [dataList valueForKey:key];
			 Data* ad = [[Data alloc] init];
			 ad.name = key;
			 ad.avg_price = [value objectForKey:@"avg_price"];
			 ad.datapoints = [[value objectForKey:@"datapoints"] intValue];
			 ad.month = [value objectForKey:@"month"];
			 
			 [[md data] addObject: ad];
			 [ad release], ad = nil;
		 }
		
		 md.currency = [meta objectForKey:@"currency"];
		 md.listing_type = [meta objectForKey:@"listing_type"];
		 md.metadata_name = [meta objectForKey:@"metadata_name"];
		 md.num_beds = [meta objectForKey:@"num_beds"];
		 md.num_rooms = [meta objectForKey:@"num_rooms"];
		 md.price_type = [meta objectForKey:@"price_type"];
		 md.property_type = [meta objectForKey:@"property_type"];
		 md.url = [meta objectForKey:@"url"];

		 [model.response.metadata addObject: md];
         [md release], md = nil;
	 }

	[aMetaData release];
	return flag;
}
-(BOOL)consumingLabels: (NSArray*)aLabels {
	BOOL flag = YES;
	[aLabels retain];
	for (NSDictionary* l in aLabels) {
		Labels* ll = [[Labels alloc] init];
		ll.english = [l objectForKey:@"english"];
		ll.keyword = [l objectForKey:@"keyword"];
		[model.response.labels addObject: ll];
		[ll release], ll = nil;
	}
	[aLabels release];
	return flag;
}


@end

//
//  ResponseObject.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Attribuition;


@interface ResponseObject : NSObject {
@protected
	Attribuition* attribution;
	NSMutableArray* listings;
	NSMutableArray* locations;
	NSMutableArray* metadata;
	
	NSMutableArray* labels;

	
	NSString* action		       ;
	NSString* application_response_code   ;
	NSString* application_response_text   ;
	NSString* country		       ;
	NSString* created_http		       ;
	uint created_unix		       ;
	NSString* encoding		       ;
	NSString* keywords		       ;
	NSString* link_to_url		       ;
	NSString* most_recent_month	       ;
	NSString* most_recent_quarter	       ;
	NSString* page			       ;
	NSString* sort			       ;
	NSString* status_code		       ;
	NSString* status_text		       ;
	NSString* thanks		       ;
	uint total_pages		       ;
	uint total_results	       ;
	
}

@property(nonatomic, retain) Attribuition* attribution;
@property(nonatomic, retain) NSMutableArray* listings;
@property(nonatomic, retain) NSMutableArray* locations;
@property(nonatomic, retain) NSMutableArray* metadata;
@property(nonatomic, retain) NSMutableArray* labels;

@property(nonatomic, copy)  NSString* action		       ;
@property(nonatomic, copy)  NSString* application_response_code   ;
@property(nonatomic, copy)  NSString* application_response_text   ;
@property(nonatomic, copy)  NSString* country		       ;
@property(nonatomic, copy)  NSString* created_http		       ;
@property(nonatomic, assign)  uint created_unix		       ;
@property(nonatomic, copy)  NSString* encoding		       ;
@property(nonatomic, copy)  NSString* keywords		       ;
@property(nonatomic, copy)  NSString* link_to_url		       ;
@property(nonatomic, copy)  NSString* most_recent_month	       ;
@property(nonatomic, copy)  NSString* most_recent_quarter	       ;
@property(nonatomic, copy)  NSString* page			       ;
@property(nonatomic, copy)  NSString* sort			       ;
@property(nonatomic, copy)  NSString* status_code		       ;
@property(nonatomic, copy)  NSString* status_text		       ;
@property(nonatomic, copy)  NSString* thanks		       ;
@property(nonatomic, assign)  uint total_pages		       ;
@property(nonatomic, assign) uint total_results	       ;
@end

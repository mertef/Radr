//
//  MetaData.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
{
	@protected
	NSString* name;
	NSString* avg_price;
	uint datapoints;
	NSString* month;
}

@property(nonatomic, copy) NSString* name, * avg_price, * month;
@property(nonatomic, assign) uint datapoints;
@end

@interface MetaData : NSObject {
  @protected
	NSMutableArray* data;
	
	
	NSString* currency        ;
	NSString* listing_type	   ;
	NSString* metadata_name   ;
	NSString* num_beds	   ;
	NSString* num_rooms	   ;
	NSString* price_type	   ;
	NSString* property_type   ;
	NSString* url 	     	   ;
	
}
@property(nonatomic, retain) NSMutableArray* data;
@property(nonatomic, copy) NSString* currency	  ;
@property(nonatomic, copy) NSString* listing_type	   ;
@property(nonatomic, copy) NSString* metadata_name	  ;
@property(nonatomic, copy) NSString* num_beds	   ;
@property(nonatomic, copy) NSString* num_rooms	   ;
@property(nonatomic, copy) NSString* price_type	   ;
@property(nonatomic, copy) NSString* property_type	  ;
@property(nonatomic, copy) NSString* url		   ;
@end

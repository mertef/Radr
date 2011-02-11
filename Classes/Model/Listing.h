//
//  Listing.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Listing : NSObject {
@protected
	uint  auction_date;
	NSString*  bathroom_number                ;
	NSString*  bedroom_number                 ;
	uint  car_spaces                	  ;
	float commission                	  ;
	uint  construction_year         	  ;
	NSString*  datasource_name           	  ;
	NSString*  guid                      	  ;
	uint  img_height                	  ;
	NSString*  img_url                   	  ;
	uint  img_width                 	  ;
	NSString*  keywords                  	  ;
	NSString*  land_size                 	  ;
	NSString*  land_size_unit            	  ;
	float  latitude                  	  ;
	NSString*  lister_name               	  ;
	NSString*  lister_url                	  ;
	NSString*  listing_type                  	  ;
	uint  location_accuracy         	  ;
	float  longitude                 	  ;
	uint  price                     	  ;
	NSString*  price_currency            	  ;
	NSString*  price_formatted           	  ;
	uint  price_high                	  ;
	uint  price_low                 	  ;
	NSString*  price_type                   	  ;
	NSString*  property_type                 	  ;
	uint  room_number               	  ;
	NSString*  size                      	  ;
	NSString*  size_unit                 	  ;
	NSString*  summary                   	  ;
	uint  thumb_height              	  ;
	NSString*  thumb_url                 	  ;
	uint  thumb_width               	  ;
	NSString*  title                     	  ;
	float  updated_in_days           	  ;
	NSString* updated_in_days_formatted      ;
	//
	NSData* thumb_img_data;
	
}
@property(nonatomic, assign) uint  auction_date                	  ;
@property(nonatomic, copy) NSString*  bathroom_number                	  ;
@property(nonatomic, copy) NSString*  bedroom_number                	  ;
@property(nonatomic, assign) uint  car_spaces                	  ;
@property(nonatomic, assign) float  commission                	  ;
@property(nonatomic, assign) uint  construction_year         	  ;
@property(nonatomic, copy) NSString*  datasource_name           	  ;
@property(nonatomic, copy) NSString*  guid                      	  ;
@property(nonatomic, assign) uint  img_height                	  ;
@property(nonatomic, copy) NSString*  img_url                   	  ;
@property(nonatomic, assign) uint  img_width                 	  ;
@property(nonatomic, copy) NSString*  keywords                  	  ;
@property(nonatomic, copy) NSString*  land_size                 	  ;
@property(nonatomic, copy) NSString*  land_size_unit            	  ;
@property(nonatomic, assign) float   latitude                  	  ;
@property(nonatomic, copy) NSString*  lister_name               	  ;
@property(nonatomic, copy) NSString*  lister_url                	  ;
@property(nonatomic, copy) NSString*  listing_type                  	  ;
@property(nonatomic, assign) uint  location_accuracy         	  ;
@property(nonatomic, assign) float   longitude                 	  ;
@property(nonatomic, assign) uint  price                     	  ;
@property(nonatomic, copy) NSString*  price_currency            	  ;
@property(nonatomic, copy) NSString*  price_formatted           	  ;
@property(nonatomic, assign) uint  price_high                	  ;
@property(nonatomic, assign) uint  price_low                 	  ;
@property(nonatomic, copy) NSString*  price_type                    	  ;
@property(nonatomic, copy) NSString*  property_type                 	  ;
@property(nonatomic, assign) uint  room_number               	  ;
@property(nonatomic, copy) NSString*  size                      	  ;
@property(nonatomic, copy) NSString*  size_unit                 	  ;
@property(nonatomic, copy) NSString*  summary                   	  ;
@property(nonatomic, assign)uint  thumb_height              	  ;
@property(nonatomic, copy, setter=setThumbUrl) NSString*  thumb_url                 	  ;
@property(nonatomic, assign) uint  thumb_width               	  ;
@property(nonatomic, copy) NSString*  title                     	  ;
@property(nonatomic, assign) float  updated_in_days           	  ;
@property(nonatomic, copy) NSString*  updated_in_days_formatted 	  ;

//
@property(retain) NSData* thumb_img_data;


-(void)getImageData:(id)aSender;
-(void)getImageData;
@end

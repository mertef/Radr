//
//  RequestObject.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestObject : NSObject {
	NSString* action            ;
	NSString* country	       	;
	NSString* encoding	       	;
	NSString* guid		       	;
	NSString* language	       	;
	NSString* location	       	;
	uint num_res	       	;
	uint offset	       	;
	NSString* output	       	;
	uint page		       	;
	NSString* product_type	    ;
	NSString* property_type     ;
	NSString* sort		       	;
	NSString* list_type         ;
}
@property(nonatomic, copy)   NSString* action              	;
@property(nonatomic, copy)   NSString* country	       	;
@property(nonatomic, copy)   NSString* encoding	       	;
@property(nonatomic, copy)   NSString* guid		       	;
@property(nonatomic, copy)   NSString* language	       	;
@property(nonatomic, copy)   NSString* location	       	;
@property(nonatomic, assign)   uint num_res	       	;
@property(nonatomic, assign)   uint offset	       	;
@property(nonatomic, copy)   NSString* output	       	;
@property(nonatomic, assign)   uint page		       	;
@property(nonatomic, copy)   NSString* product_type	       	;
@property(nonatomic, copy)   NSString* property_type       	;
@property(nonatomic, copy)   NSString* sort		       	;
@property(nonatomic, copy) NSString* listing_type;
@end

//
//  RequestObject.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "RequestObject.h"


@implementation RequestObject
@synthesize action		   ;
@synthesize country		;
@synthesize encoding		;
@synthesize guid			;
@synthesize language		;
@synthesize location		;
@synthesize num_res		;
@synthesize offset		;
@synthesize output		;
@synthesize page			;
@synthesize product_type	    ;
@synthesize property_type	   ;
@synthesize sort			;
@synthesize listing_type;

-(void) dealloc {
	
	[action  	   release	];
	[country	   release	];
	[encoding	   release	];
	[guid		   release	];
	[language	   release	];
	[location	   release	];
	num_res	   = 0;
	offset	   = 0;
	[output	   release	];
	page	   = 0;
	[product_type	   release	];
	[property_type	   release	];
	[sort		   release	];
	[listing_type release];
	[super dealloc];
}
@end

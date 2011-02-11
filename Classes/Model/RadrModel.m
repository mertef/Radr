//
//  RadrModel.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "RadrModel.h"
#import "RequestObject.h"
#import "ResponseObject.h"

@implementation RadrModel
@synthesize request;
@synthesize response;

- (id) init
{
	self = [super init];
	if (self != nil) {
		request = [[RequestObject alloc] init];
		response = [[ResponseObject alloc] init];
	}
	return self;
}


- (void) dealloc
{
	[request release], request = nil;
	[response release], response = nil;
	[super dealloc];
}

@end

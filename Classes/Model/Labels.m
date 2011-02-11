//
//  Labels.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "Labels.h"


@implementation Labels
@synthesize keyword, english;

- (void) dealloc
{
	[keyword release], keyword = nil;
	[english release], english = nil;
	[super dealloc];
}

@end

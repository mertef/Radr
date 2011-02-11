//
//  Attribuition.m
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "Attribuition.h"


@implementation Attribuition
@synthesize img_height, img_width;
@synthesize img_url, link_to_img;

- (void) dealloc
{
	img_height = 0;
	img_width = 0;
	[img_url release], img_url = nil;
	[link_to_img release], link_to_img = nil;
	[super dealloc];
}


@end

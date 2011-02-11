//
//  ChartAxisLayer.m
//  RadrApp
//
//  Created by zhangdong on 2/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChartLayer.h"
@interface ChartLayer(Private)
-(void)drawUpAxis;
-(void)drawRighttAxis;
-(void)drawContents;
@end


@implementation ChartLayer

-(id)initWithFrame: (CGRect)aFrame {
   if (self = [super init]) {
	   self.frame = aFrame;
   }
	return self;
}
- (void)drawInContext:(CGContextRef)ctx {
	[super drawInContext:ctx];
	[self drawUpAxis];
	[self drawRighttAxis];
	[self drawContents];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Private
-(void)drawUpAxis {
	
}

-(void)drawRighttAxis {
	
}
-(void)drawContents {
	
}

@end

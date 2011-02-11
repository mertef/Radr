//
//  Attribuition.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Attribuition : NSObject {
	@protected
	uint img_height;
	NSString* img_url;
	uint img_width;
	NSString* link_to_img;
}
@property(nonatomic, copy) NSString* img_url;
@property(nonatomic, copy) NSString* link_to_img;
@property(nonatomic, assign) uint img_height, img_width;
@end

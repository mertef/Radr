//
//  Locations.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Location : NSObject {
	float center_lat;
	float center_long;
	NSString* long_title;
	NSString* place_name;
	NSString* title;
}
@property(nonatomic, copy) NSString* long_title, *place_name, *title;
@property(nonatomic, assign) float center_lat, center_long;
@end

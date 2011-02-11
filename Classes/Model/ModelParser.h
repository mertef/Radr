//
//  ModelParser.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RadrModel;

@interface ModelParser : NSObject {
	@protected
	RadrModel* model;
}

-(BOOL)consumingJoson: (NSDictionary*)aJSonDictionary;
@property(nonatomic, retain) RadrModel* model;
@end

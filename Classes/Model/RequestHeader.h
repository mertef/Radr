//
//  Request.h
//  RadrApp
//
//  Created by zhangdong on 1/18/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RequestHeader : NSObject {

	@package
	NSMutableDictionary* headerDictionary;
	NSMutableDictionary* varyDictinary;
	NSArray* headerKeys;
	NSString* api_addr;
	@protected
	NSMutableString* reqUrl;
}

@property(nonatomic, retain) NSMutableDictionary* headerDictionary; 
@property(nonatomic, copy) NSString* api_addr;


-(void)setHeader:(NSString*)aValue forKey: (NSString*)aKey;
-(void)addUserHeader:(NSString*)aValue key: (NSString*)aKey;

-(void)resetAllValues;
-(NSString*)getHeader;
-(NSMutableDictionary*)getHeaderDictionary;
@end

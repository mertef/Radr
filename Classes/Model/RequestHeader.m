//
//  Request.m
//  RadrApp
//
//  Created by zhangdong on 1/18/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "RequestHeader.h"
#import "Config.h"


@implementation RequestHeader
@synthesize  headerDictionary;
@synthesize api_addr;
- (id) init
{
	self = [super init];
	if (self != nil) {
		/*
		 static const NSString* header_action = @"action";
		 static const NSString* header_country = @"country";
		 static const NSString* header_encoding = @"encoding";
		 static const NSString* header_guid = @"guid";
		 static const NSString* header_language = @"language";
		 static const NSString* header_location = @"location";
		 static const NSString* header_num_res = @"num_res";
		 static const NSString* header_offset = @"offset";
		 static const NSString* header_page = @"page";
		 
		 static const NSString* header_output = @"output";
		 static const NSString* header_product_type = @"product_type";
		 static const NSString* header_property_type = @"property_type";
		 static const NSString* header_sort = @"sort";
		 
		 static const NSString* header_version = @"";
		 static const NSString* header_pretty  = @"";
		 static const NSString* header_callback = @""
		 
		 */
		headerKeys = [NSArray arrayWithObjects:header_action, 
					  header_country,
					  header_encoding,
					  header_guid,
					  header_language,
					  header_location,
					  header_num_res,
					  header_offset,
					  header_page,
					  header_output,
					  header_product_type,
					  header_property_type,
					  header_sort,
					  header_version,
					  header_pretty,
					  header_callback ,
					  nil];
		[headerKeys retain];
		NSDictionary* configDic = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"]];
		NSString* country = [configDic objectForKey:@"default"];
		NSString* server_addr = [[configDic objectForKey:@"servers"] objectForKey: country];
		
		api_addr = [server_addr retain];
		//api_addr = @"http://api.nestoria.co.uk/api?";
		
		NSMutableArray* headerValues = [[NSMutableArray alloc] initWithCapacity: [headerKeys count]];
		varyDictinary = [[NSMutableDictionary alloc] init];
		for (int i = 0; i < [headerKeys count]; i ++) {
			[headerValues addObject:@""];
		}

		headerDictionary = [[NSMutableDictionary alloc] initWithObjects:headerValues forKeys:headerKeys];
		[headerDictionary setObject:country forKey:header_country];
		[headerDictionary setObject:@"json" forKey:header_encoding];
		[headerDictionary setObject:@"1" forKey:header_pretty];
		[headerValues release], headerValues = nil;
		
	}
	return self;
}

- (void) dealloc
{
	[api_addr release], api_addr = nil;
	[headerKeys release], headerKeys = nil;
	[headerDictionary release], headerDictionary = nil;
	[reqUrl release], reqUrl = nil;
	[varyDictinary release], varyDictinary = nil;
	[super dealloc];
}

-(NSString*)getHeader {
	NSMutableString* url = [[NSMutableString alloc] initWithFormat: @"%@", api_addr];
//	int index = 0;
	for (NSString* key in headerKeys) {
		NSString* value = [headerDictionary objectForKey:key];
		if ([value isEqualToString:@""] == NO) {
			[url appendFormat:@"%@=%@&", key,value ];
		}
	}
	NSArray* varyKeys = [varyDictinary allKeys];
	
	for (NSString* key in varyKeys) {
		NSString* value = [varyDictinary objectForKey:key];
		if ([value isEqualToString:@""] == NO) {
			[url appendFormat:@"%@=%@&", key,value ];
		}
	}
	
    [url replaceCharactersInRange:NSMakeRange([url length] - 1, 1) withString:@""];
	NSLog(@"%@", url);
	return [url autorelease];	
}

-(NSMutableDictionary*)getHeaderDictionary {
	NSMutableDictionary* headerDic = [[NSMutableDictionary alloc] initWithCapacity:[headerDictionary count]];	
	for (NSString* key in headerKeys) {
		NSString* value = [headerDictionary objectForKey:key];
		if ([value isEqualToString:@""] == NO) {
			[headerDic setObject:value forKey:key];
		}
	}
	NSArray* varyKeys = [varyDictinary allKeys];
	
	for (NSString* key in varyKeys) {
		NSString* value = [varyDictinary objectForKey:key];
		if ([value isEqualToString:@""] == NO) {
			[headerDic setObject:value forKey:key];
		}
	}
	
	return [headerDic autorelease];
}
-(void)setHeader:(NSString*)aValue forKey: (NSString*)aKey {
   if ([headerKeys containsObject: aKey]) {
	   [headerDictionary setObject:aValue forKey:aKey];
   }	
}

-(void)addUserHeader:(NSString*)aValue key: (NSString*)aKey {
	[varyDictinary setObject: aValue forKey:aKey];	
}
-(void)resetAllValues {
	for (int i = 0; i < [headerKeys count]; i ++) {
		[headerDictionary setObject:@"" forKey:[headerKeys objectAtIndex:i]];
	}
}
@end

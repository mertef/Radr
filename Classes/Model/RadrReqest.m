//
//  RadrReqest.m
//  RadrApp
//
//  Created by zhangdong on 1/18/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "RadrReqest.h"
#import "RequestHeader.h"
#import "ModelParser.h"
#import "JSON.h"

@interface RadrReqest(Pivate)
-(void)displayResponseInformatin: (NSArray*)aResArray;
@end

@implementation RadrReqest
@synthesize header;
@synthesize delegator;
@synthesize mParser;


- (void) dealloc
{
	[header release], header = nil;
	delegator = nil;
	[responsedData release], responsedData = nil;
	[jparser release], jparser = nil;
	[mParser release], mParser = nil;
	[super dealloc];
}


-(id)initWithHeader: (RequestHeader*)aHeader {
	return [self initWithHeader:aHeader andDelegator:nil] ;
}

-(id)initWithHeader: (RequestHeader*)aHeader andDelegator: (id)aDelegator {
	self = [super init];
	if (self != nil) {
		if (aDelegator != nil) {
			delegator = aDelegator;
		}

		self.header = aHeader;
		responsedData = [[NSMutableData alloc] initWithCapacity:512];
		jparser = [[SBJsonParser alloc] init];
		mParser = [[ModelParser alloc] init];
		NSMutableURLRequest* urlReq = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[header getHeader]]];
		conn = [[NSURLConnection alloc] initWithRequest:urlReq delegate:self startImmediately:YES];
		[urlReq release];
	}
	return self;
}

-(void)sendRequest {
	[conn start];
}

#pragma mark -
#pragma mark url delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSHTTPURLResponse* httpResponse = nil;
	httpResponse = (NSHTTPURLResponse*)(response);
	assert([httpResponse isKindOfClass:[NSHTTPURLResponse class]]);
	NSLog(@"status code is %d", [httpResponse statusCode]);
	NSLog(@"header:%@", [httpResponse allHeaderFields]);
    [responsedData setLength:0];	
	
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responsedData appendData: data];
	
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	
	NSString* resDataString = [[NSString alloc] initWithData:responsedData encoding:NSUTF8StringEncoding];
	NSLog(@"===========================");
	NSLog(@"%@", resDataString);
	NSLog(@"===========================");

	NSError* parsingError = nil;
	NSDictionary* resDictionary = [jparser objectWithString:resDataString error:&parsingError];
	
	//NSArray* resReqestObjects = [resDictionary objectForKey:@"request"];
	if (parsingError == nil) {
		if([mParser consumingJoson:resDictionary ]) {
			[delegator modelFinished: mParser.model];
		}else {
			if ([(NSObject*)delegator respondsToSelector:@selector(error:description:)]) {
				[delegator error:self description: [NSString stringWithString: @"Parssing model Error"]];
			}
		}

		//[self displayResponseInformatin:resReqestObjects];
		
	}else {
		NSLog(@"%@", [NSString stringWithFormat:@"Json parsing error %@", [parsingError localizedDescription]]);
	}
	
	[resDataString release], resDataString = nil;
	
    [connection release], connection = nil;	
	[jparser release], jparser = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSString* errorString =  [NSString stringWithFormat:@"connection error %@", [error localizedDescription]];
	NSLog(@"%@", errorString);
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NetWork Error!", @"RadrRequest") message:errorString delegate:nil cancelButtonTitle:NSLocalizedString(@"Yes", @"RadrRequest") otherButtonTitles:nil];
	[alert show];
	[alert release];
	alert = nil;
	if(delegator != nil){
		if ([(NSObject*)delegator respondsToSelector:@selector(error:description:)]) {
			[delegator error:self description: errorString];
		}
	}
}


#pragma mark -
#pragma mark priviate implementation
-(void)displayResponseInformatin: (NSArray*)aResArray {
	[aResArray retain];
	for (NSDictionary* item in aResArray) {
		NSLog(@"%@", item);
	}
	[aResArray release];
}

@end

//
//  RadrReqest.h
//  RadrApp
//
//  Created by zhangdong on 1/18/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestHeader;
@class ModelParser;
@class RadrModel;
@class SBJsonParser;
@class RadrReqest;

@protocol RadrRequestProtocol
@required
-(void)modelFinished:(RadrModel*)aModel;
@optional
-(void)error: (RadrReqest*)aRequest description:(NSString*)aDescription;
@end


@interface RadrReqest : NSObject {
	@protected
	RequestHeader* header;
	id<RadrRequestProtocol> delegator;
	@private
	NSURLConnection* conn;
	NSMutableData* responsedData;
	SBJsonParser* jparser;
	ModelParser* mParser;
}
@property(nonatomic, retain) RequestHeader* header;
@property(nonatomic, assign) id<RadrRequestProtocol> delegator;
@property(nonatomic, assign) ModelParser* mParser;

-(id)initWithHeader: (RequestHeader*)aHeader;
-(id)initWithHeader: (RequestHeader*)aHeader andDelegator: (id)aDelegator;
-(void)sendRequest;
@end

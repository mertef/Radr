//
//  RadrModel.h
//  RadrApp
//
//  Created by zhangdong on 1/19/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RequestObject;
@class ResponseObject;
@interface RadrModel : NSObject {
	@protected
	RequestObject* request;
	ResponseObject* response;
}
@property(nonatomic, retain) RequestObject* request;
@property(nonatomic, retain) ResponseObject* response;
@end

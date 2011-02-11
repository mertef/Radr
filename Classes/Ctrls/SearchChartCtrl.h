//
//  SearchChartCtrl.h
//  RadrApp
//
//  Created by zhangdong on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadrReqest.h"

@class RadrModel;


@interface SearchChartCtrl : UIViewController<RadrRequestProtocol> {
	UIImageView* chartView, * chartTableView;
	RadrModel* model;
	@private
	NSMutableData* imageData;
}
-(id)initWithMode: (RadrModel*)aMode;
-(NSString*)createGoogleChartURLString;
@property(nonatomic, retain) UIView* chartView, * chartTableView;
@property(nonatomic, retain) RadrModel* model;
@end

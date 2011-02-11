//
//  RadrAppViewController.h
//  RadrApp
//
//  Created by zhangdong on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadrReqest.h"

@class RequestHeader;

@interface SearchCtrl : UIViewController<UITextFieldDelegate, RadrRequestProtocol> {
	@protected
	 UILabel* applicationTitle;
	 UIImageView* navigationImg;
	 UIImageView* searchingImg;
	 UITextField* searchTxt;
	 UIButton* forSaleBtn;
	 UIButton* forRentBtn;
	@private
	RequestHeader* reqheader;
}
@property(nonatomic, retain) IBOutlet UILabel* applicationTitle;
@property(nonatomic, retain) IBOutlet UIImageView* navigationImg, *searchingImg;
@property(nonatomic, retain) IBOutlet UITextField* searchTxt;
@property(nonatomic, retain) IBOutlet UIButton* forSaleBtn, * forRentBtn;
-(IBAction)forRentBtnPressed: (id)aSender;
-(IBAction)forSaleBtnPressed: (id)aSender;
@end


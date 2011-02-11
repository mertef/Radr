//
//  SearchListCtrlCell.h
//  RadrApp
//
//  Created by zhangdong on 1/24/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchListCtrlCell : UITableViewCell {
@protected
	UILabel* price;
	UILabel* description;
	UILabel* numberOfRooms;
	UILabel* numberOfBatherooms;
	UIImageView* roomImgView;
	UIImageView* batheImgView;
	UIImageView* thumbImgView;
}
@property(nonatomic, retain) UILabel* price, * description, *numberOfRooms, * numberOfBatherooms;
@property(nonatomic, retain) UIImageView* roomImgView, *batheImgView, *thumbImgView;

@end

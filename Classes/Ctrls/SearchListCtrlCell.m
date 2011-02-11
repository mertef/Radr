//
//  SearchListCtrlCell.m
//  RadrApp
//
//  Created by zhangdong on 1/24/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "SearchListCtrlCell.h"


@implementation SearchListCtrlCell
/*
 UILabel* price;
 UILabel* description;
 UILabel* numberOfRooms;
 UILabel* numberOfBatherooms;
 UIImageView* roomImgView;
 UIImageView* batheImgView;
 */
@synthesize price, description, numberOfRooms, numberOfBatherooms;
@synthesize roomImgView, batheImgView, thumbImgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		CGRect contentFrame = self.contentView.bounds;
		float dy = contentFrame.size.height / 4.0f;
		float dx = contentFrame.size.width;
		
		CGRect thumbImgViewFrame = contentFrame;
		thumbImgViewFrame.size.width = 60; 
		thumbImgView = [[UIImageView alloc] initWithFrame:thumbImgViewFrame];
		[self.contentView addSubview:thumbImgView];
		
		
		CGRect priceFrame = CGRectMake(thumbImgViewFrame.size.width, 0.0f,  dx, dy);
		price = [[UILabel alloc] initWithFrame:priceFrame];
		[price setFont:[UIFont systemFontOfSize: dy]];
		[self.contentView addSubview: price];
		
		
		CGRect descriptionFrame = CGRectMake(thumbImgViewFrame.size.width, dy,  dx, dy * 3);
		description = [[UILabel alloc] initWithFrame:descriptionFrame];
		description.lineBreakMode = UILineBreakModeTailTruncation;
		[description setNumberOfLines: 3];
		[description setAdjustsFontSizeToFitWidth:YES];
		[description setFont:[UIFont systemFontOfSize: dy]];
		[self.contentView addSubview: description];
		
		
		
		dx = dx / 10.0f;
		
		CGRect numberOfRoomsFrame = CGRectMake(thumbImgViewFrame.size.width, descriptionFrame.origin.y + descriptionFrame.size.height,  dx, dy);
		numberOfRooms = [[UILabel alloc] initWithFrame:numberOfRoomsFrame];
		[numberOfRooms setFont:[UIFont systemFontOfSize: dy]];
		[self.contentView addSubview: numberOfRooms];
		
		CGRect roomImgViewFrame = CGRectMake(thumbImgViewFrame.size.width + dx + 2.0f, numberOfRoomsFrame.origin.y, dx, dy);
		roomImgView = [[UIImageView alloc] initWithFrame: roomImgViewFrame];
		[self.contentView addSubview: roomImgView];
		
		
		CGRect numberOfBatheroomsFrame = CGRectMake(thumbImgViewFrame.size.width + roomImgViewFrame.origin.x + dx + 2.0f, numberOfRoomsFrame.origin.y, dx, dy);
		numberOfBatherooms = [[UILabel alloc] initWithFrame:numberOfBatheroomsFrame];
		[numberOfBatherooms setFont:[UIFont systemFontOfSize: dy]];
		[self.contentView addSubview: numberOfBatherooms];
		
		CGRect batheViewFrame = CGRectMake(thumbImgViewFrame.size.width + numberOfBatheroomsFrame.origin.x + dx +  2.0f, numberOfRoomsFrame.origin.y,  dx, dy);
		batheImgView = [[UIImageView alloc] initWithFrame: batheViewFrame];
		[self.contentView addSubview: batheImgView];
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[price release], price = nil;
	[description release], description = nil;
	[numberOfRooms release], numberOfRooms = nil;
	[numberOfBatherooms release], numberOfBatherooms = nil;
	[roomImgView release], roomImgView = nil;
	[batheImgView release], batheImgView = nil;
	[thumbImgView release], thumbImgView = nil;
    [super dealloc];
}


@end

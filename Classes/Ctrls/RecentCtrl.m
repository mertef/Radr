//
//  RecentCtrl.m
//  RadrApp
//
//  Created by zhangdong on 1/20/11.
//  Copyright 2011 www.cybercom.com. All rights reserved.
//

#import "RecentCtrl.h"


@implementation RecentCtrl

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden: YES];
} 

- (void) dealloc
{
	[super dealloc];
}
@end

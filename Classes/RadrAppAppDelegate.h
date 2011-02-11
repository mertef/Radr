//
//  RadrAppAppDelegate.h
//  RadrApp
//
//  Created by zhangdong on 1/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchCtrl;

@interface RadrAppAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
	IBOutlet UITabBarController*    tabMainCtl;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic, retain) IBOutlet UITabBarController* tabMainCtl;

@end


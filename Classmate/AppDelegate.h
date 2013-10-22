//
//  AppDelegate.h
//  Classmate
//
//  Created by icreative-mini on 13-5-6.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWWTabbar.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CustomTabbarDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarControl;
@property (strong, nonatomic) ViewController *viewController;

@end

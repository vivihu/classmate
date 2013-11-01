//
//  AppDelegate.m
//  Classmate
//
//  Created by icreative-mini on 13-5-6.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "AppDelegate.h"
#import "PhotoViewController.h"
#import "ViewController.h"
#import "ShelfView.h"
#import "DetailInfoViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //  背景*******
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageV.image = [UIImage imageNamed:@"IMG_0025.JPG"];
    [self.window addSubview:imageV];
//[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    PhotoViewController *photo = [[PhotoViewController alloc] initWithCollectionViewLayout:[PSUICollectionViewFlowLayout new]];
    
    DetailInfoViewController *menuRoot = [[DetailInfoViewController alloc] init];
    self.tabBarControl = [[BasicTabbarController alloc] init];
    self.tabBarControl.viewControllers = [NSArray arrayWithObjects:self.viewController,photo,menuRoot, nil];
    
    [self createTabbar];
    self.window.rootViewController = self.tabBarControl;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)createTabbar
{
    //  隐藏tabbar
    [self hideTabBar];
    //  创建tabbar
    HWWTabbar *customTabbar = [[HWWTabbar alloc] initWithDelegate:self withItems:4];
    customTabbar.backgroundColor = [UIColor clearColor];
    [self.tabBarControl.view addSubview:customTabbar];
    [customTabbar selectFirstButton];
    
    /*  改名字  */
    [[customTabbar.btnArray objectAtIndex:0] setTitle:@"songs" forState:UIControlStateNormal];
    [[customTabbar.btnArray objectAtIndex:1] setTitle:@"U" forState:UIControlStateNormal];
    [[customTabbar.btnArray objectAtIndex:2] setTitle:@"W" forState:UIControlStateNormal];
    [[customTabbar.btnArray objectAtIndex:3] setTitle:@"W" forState:UIControlStateNormal];
}

- (void)hideTabBar {
    UIView *contentView;
    if ([[self.tabBarControl.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        contentView = [self.tabBarControl.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarControl.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,
                                   contentView.bounds.origin.y,
                                   contentView.bounds.size.width,
                                   contentView.bounds.size.height + self.tabBarControl.tabBar.frame.size.height);
    self.tabBarControl.tabBar.hidden = YES;
}

//  Delegate custom
- (void)didSelectedButtonIndex:(NSInteger)index
{
//    [self.tabBarControl setSelectedIndex:index];
    UIView * fromView = self.tabBarControl.selectedViewController.view;
    UIView * toView = [[self.tabBarControl.viewControllers objectAtIndex:index] view];
    
    if (fromView == toView) {
        return;
    }
//    toView.frame = CGRectMake(0, 0, 320, 568);
    // Transition using a page curl.
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.5
                       options:(index > self.tabBarControl.selectedIndex ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight)
                    completion:^(BOOL finished) {
                        if (finished) {
                            [self.tabBarControl setSelectedIndex:index];
                        }
                    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

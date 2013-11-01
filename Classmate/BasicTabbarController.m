//
//  BasicTabbarController.m
//  Classmate
//
//  Created by icreative-mini on 13-10-23.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "BasicTabbarController.h"

@interface BasicTabbarController ()

@end

@implementation BasicTabbarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (self.selectedViewController == [self.viewControllers firstObject]) {
        return (UIInterfaceOrientationPortrait|
                UIInterfaceOrientationLandscapeLeft|
                UIInterfaceOrientationLandscapeRight);
    }
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations {
    if (self.selectedViewController == [self.viewControllers firstObject]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (self.selectedViewController == [self.viewControllers firstObject]) {
        return (UIInterfaceOrientationLandscapeLeft);
    }
    return UIInterfaceOrientationPortrait;
}


@end

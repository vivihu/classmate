//
//  DetailViewController.m
//  Classmate
//
//  Created by icreative-mini on 13-10-22.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    // Do any additional setup after loading the view from its nib.
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
    _swipeView.backgroundColor = [UIColor darkGrayColor];
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return _data.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = (UIImageView *)view;
    
    //create or reuse view
    if (view == nil)
    {
        imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        view = imageView;
    }
    
    //configure view
    NSString *imageName = [_data objectAtIndex:index];
    imageView.image = [UIImage imageNamed:imageName];
    //return view
    return view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_swipeView scrollToItemAtIndex:_indexItem duration:0];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft|
            toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (IBAction)backToPer:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

@end

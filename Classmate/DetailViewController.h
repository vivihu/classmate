//
//  DetailViewController.h
//  Classmate
//
//  Created by icreative-mini on 13-10-22.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SwipeView/SwipeView.h>

@interface DetailViewController : UIViewController<SwipeViewDataSource,SwipeViewDelegate>
{
    IBOutlet SwipeView *_swipeView;
}

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic) NSInteger indexItem;

- (IBAction)backToPer:(id)sender;

@end

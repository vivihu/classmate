//
//  PersonDetailViewController.h
//  Classmate
//
//  Created by icreative-mini on 13-5-23.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootItem.h"
#import <SwipeView/SwipeView.h>

@interface PersonDetailView : UIViewController<SwipeViewDataSource,SwipeViewDelegate>

@property (strong, nonatomic) RootItem *rootItem;
@property (strong, nonatomic) SecondItem *secItem;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) SwipeView *swipeView;

- (void)detailData:(RootItem *)item index:(NSInteger)index;

@end

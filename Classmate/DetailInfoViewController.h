//
//  DetailInfoViewController.h
//  Classmate
//
//  Created by icreative-mini on 13-10-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@class RootItem;
@class SecondItem;
@interface DetailInfoViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSIndexPath *_indexPath;
    RootItem *_rootItem;
    SecondItem *_secItem;
}

@property (strong, nonatomic) IBOutlet UIView *detailInfo;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *mahuateng;
@property (strong, nonatomic) IBOutlet UILabel *telPhone;
@property (strong, nonatomic) IBOutlet UIImageView *photo;

@end

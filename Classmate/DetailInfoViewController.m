//
//  DetailInfoViewController.m
//  Classmate
//
//  Created by icreative-mini on 13-10-29.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "SecondItem.h"
#import "RootItem.h"

@interface DetailInfoViewController ()

@end

@implementation DetailInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    
    _rootItem = [RootItem getData];
    [self addPanGesture];
    [self createTableView];
}

#pragma mark - private method
- (void)addPanGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenDetailInfoView:)];
    [self.detailInfo addGestureRecognizer:pan];
}

- (void)createTableView
{
    CGRect rect = self.view.bounds;
    if (ios7) {
        rect.origin.y = 20;
        rect.size.height -= 20;
    }
    _tableView = [[UITableView alloc] initWithFrame:rect];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [self.view sendSubviewToBack:_tableView];
    
    _indexPath = [NSIndexPath indexPathForRow:1000 inSection:1000];
}

- (void)setDetailInformation:(SecondItem *)secItem
{
    NSString *telPhone = secItem.phoneNum.length>0?secItem.phoneNum:@"求号码";
    NSString *qq = secItem.qq.length>0?secItem.qq:@"求企鹅号";
    NSString *city = secItem.city.length>0?secItem.city:@"求地址";
    NSString *name = secItem.name.length>0?secItem.name:@"空";
    
    self.telPhone.text = telPhone;
    self.mahuateng.text = qq;
    self.city.text = city;
    self.name.text = name;
//    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",secItem.photo];
    self.photo.image = [UIImage imageNamed:@"icon.png"];
}

- (void)hiddenDetailInfoView:(UIPanGestureRecognizer *)pan
{
    CGPoint changePoint = [pan translationInView:self.detailInfo];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        return;
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        if (changePoint.x > 0) {
            CGFloat pan_x = changePoint.x + 220;
            self.detailInfo.center = CGPointMake(pan_x, self.detailInfo.center.y);
        }
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        if (changePoint.x > 30.0f) {
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 CGRect rect = self.detailInfo.frame;
                                 rect.origin.x = 320;
                                 self.detailInfo.frame = rect;
                             }completion:^(BOOL finished) {
                                 _indexPath = [NSIndexPath indexPathForRow:1000 inSection:1000];
                             }];
        }else {
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 CGRect rect = self.detailInfo.frame;
                                 rect.origin.x = 120;
                                 self.detailInfo.frame = rect;
                             }];
        }
    }
}

#pragma mark - TableView:delegate/dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rootItem.classTwo.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                      reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 1, 42, 42)];
        [picture setTag:9];
        [cell.contentView addSubview:picture];
        picture.contentMode = UIViewContentModeScaleAspectFit;
    }
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:9];
    
    if (indexPath.row > (_rootItem.classTwo.count-1)) {
        cell.textLabel.text = @"";
        imageView.image = [UIImage imageNamed:@""];
    }else {
        _secItem = (SecondItem *)[_rootItem.classTwo objectAtIndex:indexPath.row];
        cell.textLabel.text = _secItem.name;
//        imageView.image = [UIImage imageNamed:_secItem.photo];
        imageView.image = [UIImage imageNamed:@"bian.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row > (_rootItem.classTwo.count-1)) {
        return;
    }
    if (indexPath.row== _indexPath.row && indexPath.section==_indexPath.section) {
        return;
    }
    _indexPath = indexPath;
    

    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.detailInfo.frame;
        rect.origin.x = 320;
        self.detailInfo.frame = rect;
    } completion:^(BOOL finished) {
        [self setDetailInformation:_rootItem.classTwo[indexPath.row]];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = self.detailInfo.frame;
            rect.origin.x = 120;
            self.detailInfo.frame = rect;
        }];
    }];
}

@end

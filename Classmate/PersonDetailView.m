//
//  PersonDetailViewController.m
//  Classmate
//
//  Created by icreative-mini on 13-5-23.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "PersonDetailView.h"

@interface PersonDetailView ()

@end

@implementation PersonDetailView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)popLastView
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

- (void)detailData:(RootItem *)item index:(NSInteger)index
{
    self.rootItem = item;
    self.index = index;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:kFullScreen];
    imageV.image = [UIImage imageNamed:@"IMG_0026.JPG"];
    [self.view addSubview:imageV];
    

    _swipeView = [[SwipeView alloc] initWithFrame:self.view.bounds];
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
    _swipeView.itemsPerPage = 1;
    [self.view addSubview:_swipeView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(10, 10, 30, 30)];
    [button setImage:[UIImage imageNamed:@"Photo_close.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popLastView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI / 2);
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.rootItem.classTwo count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    self.secItem = (SecondItem *)[self.rootItem.classTwo objectAtIndex:index];

    NSString *phoneNumTxet = [NSString stringWithFormat:@"电话号码: %@",self.secItem.phoneNum];
    NSString *QQNumText = [NSString stringWithFormat:@"QQ : %@",self.secItem.qq];
    NSString *cityText = [NSString stringWithFormat:@"现居: %@",self.secItem.city];
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",self.secItem.photo];

    UIImageView *imageView = (UIImageView *)view;
    if (view == nil) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 28)];
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = [UIColor whiteColor];
        name.backgroundColor = [UIColor clearColor];
        [imageView addSubview:name];
        [name setTag:1];
        
        UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(13, 64, 280, 24)];
        phone.textAlignment = NSTextAlignmentLeft;
        phone.textColor = [UIColor whiteColor];
        phone.backgroundColor = [UIColor clearColor];
        [imageView addSubview:phone];
        [phone setTag:2];

        UILabel *QQ = [[UILabel alloc]initWithFrame:CGRectMake(170, 377, 138, 24)];
        QQ.textAlignment = NSTextAlignmentLeft;
        QQ.textColor = [UIColor whiteColor];
        QQ.backgroundColor = [UIColor clearColor];
        [imageView addSubview:QQ];
        [QQ setTag:3];
        
        if (iPhone5) {
            QQ.frame = CGRectMake(13, 430, 138, 24);
        }

        UILabel *cityN = [[UILabel alloc]initWithFrame:CGRectMake(13, 377, 125, 24)];
        cityN.textAlignment = NSTextAlignmentLeft;
        cityN.textColor = [UIColor whiteColor];
        cityN.backgroundColor = [UIColor clearColor];
        [imageView addSubview:cityN];
        [cityN setTag:4];

        view = imageView;
    }
    UILabel *name = (UILabel *)[imageView viewWithTag:1];
    UILabel *phone = (UILabel *)[imageView viewWithTag:2];
    UILabel *qq = (UILabel *)[imageView viewWithTag:3];
    UILabel *cityN = (UILabel *)[imageView viewWithTag:4];
    
    name.text = self.secItem.name;
    phone.text = phoneNumTxet;
    qq.text = QQNumText;
    cityN.text = cityText;

//    NSString *imagePath = [[NSBundle mainBundle]
//                           pathForResource:[imageName stringByDeletingPathExtension]
//                                    ofType:[imageName pathExtension]];
//    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    imageView.image = [UIImage imageNamed:imageName];

    return view;
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView
{

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.swipeView scrollToItemAtIndex:self.index duration:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

@end

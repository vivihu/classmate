//
//  PhotoViewController.m
//  Classmate
//
//  Created by icreative-mini on 13-5-6.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "PhotoViewController.h"
#import "CollectionCell.h"
#import "RootItem.h"
#import "PersonDetailView.h"

@interface PhotoViewController ()

@property (nonatomic,strong)RootItem *rootItem;

@end

@implementation PhotoViewController

- (id)initWithCollectionViewLayout:(PSUICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerClass:[CollectionCell class]
            forCellWithReuseIdentifier:@"collectionCell"];

    self.rootItem = [RootItem getData];
}


/***********************************分割线***********************************/

#pragma mark - DataSource AND Delegate

//- (NSInteger)numberOfSectionsInCollectionView:(PSUICollectionView *)collectionView
//{
//    return 1;
//};

- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _rootItem.classTwo.count;
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    SecondItem *indexData = (SecondItem *)[_rootItem.classTwo objectAtIndex:indexPath.row];
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",indexData.photo];
    cell.imageView.image = [UIImage imageNamed:imageName];
    if (cell.imageView.image == nil) {
        cell.imageView.image = [UIImage imageNamed:@"diaosi.png"];
    }
    cell.label.text = [indexData name];
    return cell;
}


- (void)collectionView:(PSTCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PersonDetailView *personDetail = [[PersonDetailView alloc]init];
    [personDetail detailData:_rootItem index:indexPath.row];
    [self presentModalViewController:personDetail animated:YES];
};


/***********************************分割线***********************************/

- (CGSize)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 120);
}

- (CGFloat)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 80;
}

- (UIEdgeInsets)collectionView:(PSUICollectionView *)collectionView layout:(PSUICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 80, 20);
}
/***********************************分割线***********************************/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end

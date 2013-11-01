//
//  CollectionCell.m
//  Classmate
//
//  Created by icreative-mini on 13-5-23.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor clearColor];
        CGRect rect = imageView.frame;
        [self.contentView addSubview:imageView];
        _imageView = imageView;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(rect.origin.x , rect.origin.y + rect.size.height+5, 120, 20)];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont boldSystemFontOfSize:20];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _label = label;
    }
    return self;
}

@end

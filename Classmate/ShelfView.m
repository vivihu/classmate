//
//  ShelfView.m
//  Classmate
//
//  Created by icreative-mini on 13-5-22.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "ShelfView.h"

@implementation ShelfView

const NSString *kShelfViewKind = @"ShelfView";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Apple-Wood"]]];
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0,5);
    }
    return self;
}

+ (NSString *)kind
{
    return (NSString *)kShelfViewKind;
}

- (void)layoutSubviews
{
    CGRect shadowBounds = CGRectMake(0, -5, self.bounds.size.width, self.bounds.size.height + 5);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowBounds].CGPath;
}

@end

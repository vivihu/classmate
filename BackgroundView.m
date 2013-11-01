//
//  BackgroundView.m
//  Classmate
//
//  Created by icreative-mini on 13-10-23.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (id)initWithOrigin:(CGPoint)origin
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 200, 150)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(1, 1, 198, 148)];
    [[UIColor whiteColor] setStroke];
    rectanglePath.lineWidth = 3;
    [rectanglePath stroke];
}

@end

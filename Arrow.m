//
//  leiftAndRight.m
//  Classmate
//
//  Created by icreative-mini on 13-10-2.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow

- (id)initWithOrigin:(CGPoint)origin action:(SEL)action owner:(id)owner
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 38, 52)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:owner action:action];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Polygon 2 Drawing
    UIBezierPath* polygon2Path = [UIBezierPath bezierPath];
    [polygon2Path moveToPoint: CGPointMake(19, 19)];
    [polygon2Path addLineToPoint: CGPointMake(2.55, 43)];
    [polygon2Path addLineToPoint: CGPointMake(35.45, 43)];
    [polygon2Path closePath];
    [[UIColor whiteColor] setFill];
    [polygon2Path fill];
    [[UIColor blackColor] setStroke];
    polygon2Path.lineWidth = 1;
    [polygon2Path stroke];
    
    
    //// Polygon Drawing
    UIBezierPath* polygonPath = [UIBezierPath bezierPath];
    [polygonPath moveToPoint: CGPointMake(19, -0)];
    [polygonPath addLineToPoint: CGPointMake(2.55, 24)];
    [polygonPath addLineToPoint: CGPointMake(35.45, 24)];
    [polygonPath closePath];
    [[UIColor whiteColor] setFill];
    [polygonPath fill];
    [[UIColor blackColor] setStroke];
    polygonPath.lineWidth = 1;
    [polygonPath stroke];
}

@end

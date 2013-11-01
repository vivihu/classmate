//
//  play.m
//  Classmate
//
//  Created by icreative-mini on 13-10-7.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "play.h"

@implementation play

- (id)initWithOrigin:(CGPoint)origin action:(SEL)action owner:(id)owner
{
    self = [super initWithFrame:CGRectMake(origin.x+6, origin.y+5, 40, 40)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:owner action:action];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.select_) {
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(3.5, 5.5, 34, 10)];
        [[UIColor clearColor] setFill];
        [rectanglePath fill];
        [[UIColor blueColor] setStroke];
        rectanglePath.lineWidth = 1;
        [rectanglePath stroke];
        
        
        //// Rectangle 3 Drawing
        UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake(3.5, 20.5, 34, 10)];
        [[UIColor clearColor] setFill];
        [rectangle3Path fill];
        [[UIColor blueColor] setStroke];
        rectangle3Path.lineWidth = 1;
        [rectangle3Path stroke];
    }
    else{
        //// Polygon Drawing
        UIBezierPath* polygonPath = [UIBezierPath bezierPath];
        [polygonPath moveToPoint: CGPointMake(20, -0)];
        [polygonPath addLineToPoint: CGPointMake(2.68, 30)];
        [polygonPath addLineToPoint: CGPointMake(37.32, 30)];
        [polygonPath closePath];
        [[UIColor clearColor] setFill];
        [polygonPath fill];
        [[UIColor blueColor] setStroke];
        polygonPath.lineWidth = 1;
        [polygonPath stroke];
        
    }
}
    


@end

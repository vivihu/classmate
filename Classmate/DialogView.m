//
//  DialogView.m
//  Classmate
//
//  Created by icreative-mini on 13-10-18.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "DialogView.h"

#define kLineWidth 3
#define kColor [UIColor redColor]
#define spacing 3

@implementation DialogView
static CGFloat v1;

- (id)initWithOrigin:(CGPoint)origin labelWord:(NSString *)word
{
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, 187, 61)];
    if (self) {
        _word = [NSString stringWithString:word];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    v1 += spacing;
    static CGFloat h1;
    h1 += spacing;
    
    //// Bezier 1 Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.5, 0.5)];
    [bezierPath addLineToPoint: CGPointMake(0.5, v1)];
    [kColor setStroke];
    bezierPath.lineWidth = kLineWidth;
    [bezierPath stroke];

    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(0.5, 0.5)];
    [bezier4Path addLineToPoint: CGPointMake(h1, 0.5)];
    [kColor setStroke];
    bezier4Path.lineWidth = kLineWidth;
    [bezier4Path stroke];

    if (v1 > 60.5) {
        
        static CGFloat h2;
        h2 += spacing;
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(0.5, 60.5)];
        [bezier2Path addLineToPoint: CGPointMake(h2, 60.5)];
        [kColor setStroke];
        bezier2Path.lineWidth = kLineWidth;
        [bezier2Path stroke];
    }
    if (h1 > 186.5) {
        
        static CGFloat v2;
        v2 += spacing;
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(186.5, 0.5)];
        [bezier3Path addLineToPoint: CGPointMake(186.5, v2)];
        [kColor setStroke];
        bezier3Path.lineWidth = kLineWidth;
        [bezier3Path stroke];
    }
}

- (void)drawLine:(NSTimer *)timer
{
    if (v1 > (186+60)) {
        [timer invalidate];
        
        UILabel *textWord = [[UILabel alloc] initWithFrame:self.bounds];
        textWord.text = _word;
        textWord.textAlignment = NSTextAlignmentCenter;
        textWord.backgroundColor = [UIColor clearColor];
        textWord.textColor = [UIColor redColor];
        textWord.font = [UIFont fontWithName:@"asdfsd" size:20];
        [self addSubview:textWord];
        
        return;
    }
    [self setNeedsDisplay];
}

@end

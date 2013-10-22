//
//  CustomTabbar.m
//  HWWTabbar
//
//  Created by icreative-mini on 13-9-10.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "HWWTabbar.h"

static HWWTabbar *shardTabBar = nil;
@implementation HWWTabbar
#define kHeight 49
#define kOriginY 15
#define kTagAdd 1000

- (id)initWithDelegate:(id)delegate withItems:(NSInteger)items
{
    CGFloat y;
    if (iPhone5) {
        y = 568 - kHeight;
    }else
        y = 480 - kHeight;
    self = [super initWithFrame:CGRectMake(0, y+kOriginY, 320, kHeight)];
    if (self) {
        self.delegate = delegate;
        
        self.btnArray = [[NSMutableArray alloc] initWithCapacity:items];
        _otherBtn = [[NSMutableArray alloc] initWithCapacity:items-1];

        CGFloat width_ = 320/items-3;
        for (int i=0; i<items; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor colorWithRed:0.133 green:0.286 blue:0.788 alpha:1.000]];
            [button setFrame:CGRectMake(2+((width_+3)*i), 0, width_, kHeight)];
            [button addTarget:self action:@selector(buttonMethod:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:i + kTagAdd];
            [button setAlpha:0.8f];
            [self addSubview:button];
            [self.btnArray addObject:button];
        }
//        //进入程序默认选择第一项
//        [self buttonMethod:[self.btnArray objectAtIndex:0]];
    }
    return self;
}

- (void)buttonMethod:(id)sender
{
    UIButton *currentBtn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(didSelectedButtonIndex:)]) {
        [self.delegate didSelectedButtonIndex:(currentBtn.tag-kTagAdd)];
    }

    [_otherBtn removeAllObjects];
    for (UIButton *btn in self.btnArray) {
        if (btn.tag == currentBtn.tag) {
            continue;
        }
        [_otherBtn addObject:btn];
    }
    
    __block CGRect rect = currentBtn.frame;
    if (currentBtn.enabled) {
        [UIView animateWithDuration:0.3f animations:^{
            rect.origin.y = -kOriginY;
            currentBtn.frame = rect;

            for (UIButton *other in _otherBtn) {
                CGRect rec = other.frame;
                rec.origin.y = 0;
                other.frame = rec;
                other.enabled = YES;
            }
        }completion:^(BOOL finished) {
            currentBtn.enabled = NO;
        }];
    }
}

- (void)selectFirstButton
{
    [self buttonMethod:[self.btnArray objectAtIndex:0]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

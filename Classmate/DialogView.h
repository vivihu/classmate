//
//  DialogView.h
//  Classmate
//
//  Created by icreative-mini on 13-10-18.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogView : UIView
{
    NSString *_word;
}
- (void)drawLine:(NSTimer *)timer;
- (id)initWithOrigin:(CGPoint)origin labelWord:(NSString *)word;

@end

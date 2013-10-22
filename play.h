//
//  play.h
//  Classmate
//
//  Created by icreative-mini on 13-10-7.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface play : UIView

@property (nonatomic)BOOL select_;

- (id)initWithOrigin:(CGPoint)origin action:(SEL)action owner:(id)owner;

@end

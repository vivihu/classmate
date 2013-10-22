//
//  SmallConferenceHeader.m
//  Classmate
//
//  Created by icreative-mini on 13-5-23.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "SmallConferenceHeader.h"

NSString *kSmallConferenceHeaderKind = @"ConferenceHeaderSmall";

@implementation SmallConferenceHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (NSString *)kind
{
    return (NSString *)kSmallConferenceHeaderKind;
}

@end

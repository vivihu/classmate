//
//  comon.h
//  Classmate
//
//  Created by icreative-mini on 13-10-22.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#ifndef Classmate_common_h
#define Classmate_common_h

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ios7 ([[UIDevice currentDevice].systemVersion doubleValue]>6.9)

#define kFullScreen [[UIScreen mainScreen] bounds]



#endif

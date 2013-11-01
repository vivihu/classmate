//
//  RootItem.m
//  Classmate
//
//  Created by icreative-mini on 13-5-23.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "RootItem.h"
#import <NSObject+JTObjectMapping.h>

@implementation RootItem

+ (id)getData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ClassTwo.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
    
    NSDictionary *dicONE = @{@"name": @"name",@"phoneNum": @"phoneNum",@"QQ": @"qq",@"city": @"city",@"photo":@"photo"};
    id firstItem = [SecondItem mappingWithKey:@"classTwo" mapping:dicONE];
    NSDictionary *dicTWO = @{@"classTwo": firstItem};
    RootItem *lastItem = [[self class] objectFromJSONObject:jsonData mapping:dicTWO];
    
    return lastItem;
}

@end

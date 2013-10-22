//
//  CustomTabbar.h
//  HWWTabbar
//
//  Created by icreative-mini on 13-9-10.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabbarDelegate <NSObject>

- (void)didSelectedButtonIndex:(NSInteger)index;

@end

@interface HWWTabbar : UIView
{
    NSMutableArray *_otherBtn;
}

@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,assign) id<CustomTabbarDelegate> delegate;

- (id)initWithDelegate:(id)delegate withItems:(NSInteger)items;
- (void)selectFirstButton;

@end

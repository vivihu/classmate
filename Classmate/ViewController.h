//
//  ViewController.h
//  Classmate
//
//  Created by icreative-mini on 13-5-6.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVFoundation.h>
#import "iCarousel.h"

@class DialogView;
@class play;
@class DetailViewController;
@interface ViewController : UIViewController
<AVAudioPlayerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,iCarouselDataSource,iCarouselDelegate>
{
    IBOutlet iCarousel *_carousel;
    DetailViewController *_detailViewController;
    NSMutableArray *_people;
    CGRect _carouselFrame;
    BOOL _horizontal;
    BOOL _startSnowAnimation;
    UIButton *_closeSnowAnimation;
    
    AVAudioPlayer* _audioPlayer;
    NSMutableArray* _pNames;
    NSMutableArray* _hNames;
    
    int _songIndex;
    play* playButton;
    DialogView *_alert;

    UILabel* _label;
    UISlider* _slider;
    UISlider* _volumeSlider;
    
    NSTimer* processTimer;
    NSTimer* snowTimer;
    NSTimer* voiceTimer;
}
-(void)loadMusic:(NSString*)name type:(NSString*)type;
@end

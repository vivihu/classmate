//
//  ViewController.m
//  Classmate
//
//  Created by icreative-mini on 13-5-6.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "ViewController.h"
#import "Arrow.h"
#import "play.h"
#import "DialogView.h"
#import "BackgroundView.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

//  iCarousel
    _carousel.type = iCarouselTypeCylinder;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.pagingEnabled = YES;
    _carousel.backgroundColor = [UIColor clearColor];
    [self createCarouselData];
    [_carousel reloadData];

    [self performSelector:@selector(dataInit)];
    [self performSelector:@selector(viewInit)];
    
    [self loadMusic:[_pNames objectAtIndex:0] type:@"mp3"];
}

- (void)createCarouselData
{
    _people = [[NSMutableArray alloc] initWithCapacity:24];
    for (int i=0; i<24; i++) {
        NSString *string = [NSString stringWithFormat:@"%d.jpg",i];
        [_people addObject:string];
    }
}

-(void)dataInit
{
    _pNames =[[NSMutableArray alloc] initWithCapacity:0];
    [_pNames addObject:@"北京东路的日子"];
    
    _hNames= [[NSMutableArray alloc] initWithCapacity:0];
    [_hNames addObject:@"北京东路的日子"];
    _songIndex=0;
}

-(void)viewInit
{
    CGFloat fit_y;

    //  标题
    _label= [[UILabel alloc] init];
    if (ios7){
        _label.frame = CGRectMake(0, 30, 320, 30);
        fit_y = kFullScreen.size.height-120;
    }else {
        _label.frame = CGRectMake(0, 20, 320, 30);
        fit_y = kFullScreen.size.height-130;
    }
    _label.font = [UIFont systemFontOfSize:25.0f];
    _label.textAlignment= NSTextAlignmentCenter;
    _label.textColor= [UIColor colorWithRed:0.133 green:0.286 blue:0.788 alpha:1.000];
    _label.numberOfLines=0;
    _label.backgroundColor= [UIColor clearColor];
    _label.text= [_hNames objectAtIndex:0];
    [self.view addSubview:_label];
    

    //  播放按钮
    playButton = [[play alloc] initWithOrigin:CGPointMake(130, fit_y) action:@selector(played) owner:self];
    playButton.transform = CGAffineTransformMakeRotation(90* M_PI/180);
    [self.view addSubview:playButton];
    //  上一曲
    Arrow *prier = [[Arrow alloc] initWithOrigin:CGPointMake(60, fit_y) action:@selector(prier) owner:self];
    prier.transform = CGAffineTransformMakeRotation(-90* M_PI/180);
    [self.view addSubview:prier];
    //  下一曲
    Arrow *next = [[Arrow alloc] initWithOrigin:CGPointMake(220, fit_y) action:@selector(next) owner:self];
    next.transform = CGAffineTransformMakeRotation(90* M_PI/180);
    [self.view addSubview:next];


    //  音量
    UIButton* voice = [UIButton buttonWithType:UIButtonTypeCustom];
    voice.frame=CGRectMake(10, _label.frame.origin.y+_label.frame.size.height+10, 40, 40);
    [voice setImage:[UIImage imageNamed:@"labalan.png"] forState:UIControlStateNormal];
    [voice addTarget:self action:@selector(showVolume) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:voice];
    //  声音进度条
    _volumeSlider= [[UISlider alloc] init];
    UIColor *volumeColor = [UIColor colorWithWhite:1.0 alpha:.8];
    _volumeSlider.maximumTrackTintColor = volumeColor;
    _volumeSlider.minimumTrackTintColor = volumeColor;
    _volumeSlider.thumbTintColor = [UIColor clearColor];
    _volumeSlider.alpha = 0.0f;
    _volumeSlider.maximumValue=1;
    _volumeSlider.minimumValue=0;
    _volumeSlider.value = 1.0f;
    [_volumeSlider addTarget:self action:@selector(volumeSet:) forControlEvents:UIControlEventValueChanged];
    _volumeSlider.transform= CGAffineTransformMakeRotation(-M_PI/2);
    
    CGFloat spacing;
    if (iPhone5)
        spacing = 50;
    else
        spacing = 10;
    _volumeSlider.frame = CGRectMake(8, voice.frame.origin.y+voice.frame.size.height+spacing, 34, 220);
    [self.view addSubview:_volumeSlider];

    
    _carousel.frame = CGRectMake(0, voice.frame.origin.y+voice.frame.size.height+spacing+5, 320, 200);
    _carouselFrame = _carousel.frame;
    
    
    //  歌曲进度条
    _slider= [[UISlider alloc] initWithFrame:CGRectMake(50, fit_y-30, 220, 1)];
    _slider.minimumTrackTintColor = [UIColor colorWithRed:0 green:0.5 blue:0.9 alpha:0.8];
    _slider.maximumTrackTintColor = volumeColor;
    [_slider setThumbImage:[[UIImage alloc] init] forState:UIControlStateNormal];
    _slider.maximumValue=100;
    _slider.minimumValue=0;
    _slider.value=0;
    _slider.continuous=NO;
    [_slider addTarget:self action:@selector(processSet:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(processTimerStop) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_slider];
    
    
//    button= [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame=CGRectMake(270, 400, 40, 40);
//    [button setTitle:@"背景" forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"apple.png"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(setBackground) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}
-(void)processSet:(UISlider*)slider
{
    
    processTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setProcess) userInfo:nil repeats:YES];
    _audioPlayer.currentTime=slider.value/100*_audioPlayer.duration;
    if(_audioPlayer.playing==YES)
        [_audioPlayer playAtTime:_audioPlayer.currentTime];
}
-(void)processTimerStop
{
    [processTimer invalidate];
}
-(void)resetVoiceTimer
{
    [voiceTimer invalidate];
    voiceTimer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(hideVoice) userInfo:nil repeats:NO];
}
//雪花函数
-(void)snow
{
    int startX= random()%568;
    int endX= random()%568;
    int width= random()%25;
    CGFloat time= (random()%100)/10+5;
    CGFloat alp= (random()%9)/10.0+0.1;
//颜色随机
//    CGFloat red= (random()%10)/10.0;
//    CGFloat green= (random()%10)/10.0;
//    CGFloat blue= (random()%10)/10.0;
    
    UIImage* image= [UIImage imageNamed:@"bian.png"];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.backgroundColor= [UIColor colorWithRed:red green:green blue:blue alpha:1];
    imageView.frame= CGRectMake(startX,-1*width,width,width);
    imageView.alpha=alp;
    [self.view addSubview:imageView];
    
    CGFloat endY;
    if (ios7)
        endY = _slider.frame.origin.y;
    else
        endY = _slider.frame.origin.y-width/2;
    
//    [UIView animateWithDuration:time
//                     animations:^{
//                         imageView.frame= CGRectMake(endX, endY, width, width);
//                     } completion:^(BOOL finished) {
//                         [imageView removeFromSuperview];
//                         imageView = nil;
//                     }];
    
    
    [UIView beginAnimations:nil context:(__bridge void *)(imageView)];
    [UIView setAnimationDuration:time];
    
//    if(endX>50&&endX<270)
//        imageView.frame= CGRectMake(endX, endY, width, width);
//    else
//        imageView.frame= CGRectMake(endX, self.view.frame.size.height-width, width, width);
    imageView.frame= CGRectMake(endX, endY, width, width);
    
    [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}
-(void)onAnimationComplete:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context
{
    UIImageView* snowView=(__bridge UIImageView *)(context);
    [snowView removeFromSuperview];
    snowView = nil;
}

//封装系统加载函数
-(void)loadMusic:(NSString*)name type:(NSString*)type
{
    NSString* path= [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSURL* url = [NSURL fileURLWithPath:path];
    
    _audioPlayer = nil;
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    _audioPlayer.delegate=self;
    [_audioPlayer prepareToPlay];
}

//播放完成
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    _songIndex++;
    if(_songIndex==_pNames.count) {
        [playButton setSelect_:NO];
        [playButton setNeedsDisplay];
        
        [snowTimer invalidate];
        snowTimer = nil;
        _songIndex = 0;
        return;
    }
    
    [self loadMusic:[_pNames objectAtIndex:_songIndex] type:@"mp3"];
    _label.text= [_hNames objectAtIndex:_songIndex];
    [_audioPlayer play];
}
//音量设置
-(void)volumeSet:(UISlider*)slider
{
    _audioPlayer.volume= slider.value;
    [self resetVoiceTimer];
}
-(void)showVolume
{
    _volumeSlider.alpha = 1.0f;
    [self resetVoiceTimer];
}
- (void)hideVoice
{
    [UIView animateWithDuration:0.5f
                     animations:^{
                         _volumeSlider.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         ;
                     }];
}

//歌曲进度
-(void)setProcess
{
//    CGFloat duration = _audioPlayer.duration - _audioPlayer.currentTime;
//    NSLog(@"%f",duration);
//    [UIView animateWithDuration:duration
//                          delay:0
//                        options:UIViewAnimationOptionCurveLinear |UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         [_slider setValue:100 animated:YES];
//                     } completion:^(BOOL finished) {
//                         [_slider setValue:0 animated:YES];
//                     }];
    _slider.value= 100*_audioPlayer.currentTime/_audioPlayer.duration;
}
//播放
-(void)played
{
    if(_audioPlayer.playing)
    {
        [playButton setSelect_:NO];
        [_audioPlayer pause];
        
        [processTimer invalidate];
        processTimer = nil;
    }
    
    else
    {
        [playButton setSelect_:YES];
        [_audioPlayer play];
        
        processTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setProcess) userInfo:nil repeats:YES];
    }
    
    [playButton setNeedsDisplay];
}

//上一首
-(void)prier
{
    BOOL playFlag;
    if(_audioPlayer.playing){
        playFlag=YES;
        [_audioPlayer stop];
    }else
        playFlag=NO;

    _songIndex--;
    if(_songIndex<0)
        _songIndex= _pNames.count-1;
    
    
    
    [self loadMusic:[_pNames objectAtIndex:_songIndex] type:@"mp3"];
    _label.text= [_hNames objectAtIndex:_songIndex];
    
    if(playFlag==YES)
    {
        [_audioPlayer play];
    }
    
    if (_pNames.count <= 1) {
        [self showAlert];
    }
}
//下一首
-(void)next
{
    BOOL playFlag;
    if(_audioPlayer.playing){
        playFlag=YES;
        [_audioPlayer stop];
    } else
        playFlag=NO;

    _songIndex++;
    if(_songIndex==_pNames.count)
        _songIndex = 0;
    
    
    [self loadMusic:[_pNames objectAtIndex:_songIndex] type:@"mp3"];
    _label.text= [_hNames objectAtIndex:_songIndex];
    if(playFlag==YES)
    {
        [_audioPlayer play];
    }
    
    
    if (_pNames.count <= 1) {
        [self showAlert];
    }
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _people.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        view.contentMode = UIViewContentModeScaleAspectFit;
        
        BackgroundView *rectView = [[BackgroundView alloc] initWithOrigin:CGPointMake(0, 25)];
        [view addSubview:rectView];
    }
    
    NSString *imageName = [_people objectAtIndex:index];
    ((UIImageView *)view).image = [UIImage imageNamed:imageName];

    return view;
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionSpacing:
        {
            if (_horizontal) {
                return value * 1.5f;
            }else
                return value * 1.4f;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (_horizontal) {
        //  横屏情况下，添加“雪花”、icarousel点击事件
        NSLog(@"cliked");
        if (!_detailViewController) {
            _detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            _detailViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        }
        _detailViewController.indexItem = index;
        _detailViewController.data = _people;
        [self presentViewController:_detailViewController animated:YES completion:^{
        }];
    }else
        return;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //  竖屏
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        _horizontal = NO;
        [self snowTimer:NO];
        _closeSnowAnimation.hidden = YES;
        
        for (UIView *subView in self.view.subviews) {
            if (subView == _carousel) {
                subView.frame = _carouselFrame;
                continue;
            }
            subView.hidden = NO;
        }
    }
    //  横屏
    else {
        [self.view bringSubviewToFront:_closeSnowAnimation];
        _horizontal = YES;
        [self snowTimer:YES];
        _closeSnowAnimation.hidden = NO;
        _startSnowAnimation = YES;
        [self snowTimerAction:_closeSnowAnimation];

        for (UIView *subView in self.view.subviews) {
            if (subView == _carousel) {
                subView.frame = self.view.frame;
                continue;
            }
            subView.hidden = YES;
        }
        
        if (!_closeSnowAnimation) {
            _closeSnowAnimation = [UIButton buttonWithType:UIButtonTypeCustom];
            [_closeSnowAnimation setTitle:@"雪花拉的多了会有点卡建议关闭" forState:UIControlStateNormal];
            [_closeSnowAnimation setTitle:@"雪花拉的少了会有点单调建议开启" forState:UIControlStateSelected];
            [_closeSnowAnimation addTarget:self action:@selector(snowTimerAction:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect rect;
            if (ios7) {
                rect = CGRectMake(20, 270, 300, 40);
            }else
                rect = CGRectMake(20, 250, 300, 40);
            [_closeSnowAnimation setFrame:rect];
            _closeSnowAnimation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [_carousel addSubview:_closeSnowAnimation];
            
            _closeSnowAnimation.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        }
    }
}

- (void)snowTimer:(BOOL)open
{
    if (open) {
        [snowTimer invalidate];
        snowTimer = nil;
        snowTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(snow) userInfo:nil repeats:YES];
    }else {
        [snowTimer invalidate];
        snowTimer = nil;
    }
}

- (void)snowTimerAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [btn setSelected:!_startSnowAnimation];
    [self snowTimer:_startSnowAnimation];
    _startSnowAnimation = !_startSnowAnimation;
}

- (void)showAlert
{
    if (!_alert) {
        CGPoint point;
        if (iPhone5) {
            if (ios7) {
                point = CGPointMake(67, 75);
            }else
                point = CGPointMake(67, 95);
        } else {
            if (ios7) {
                point = CGPointMake(67, 45);
            }else
                point = CGPointMake(67, 65);
        }
        _alert = [[DialogView alloc] initWithOrigin:CGPointMake(67, 100) labelWord:@"别点了，就一首歌！"];
        [self.view addSubview:_alert];
        [NSTimer scheduledTimerWithTimeInterval:0.02 target:_alert selector:@selector(drawLine:) userInfo:nil repeats:YES];
        [UIView animateWithDuration:0.5
                              delay:3.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _alert.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [_alert removeFromSuperview];
                             _alert = nil;
                         }];
    }
}


//背景
//-(void)setBackground
//{
//    UIImagePickerController* picker= [[UIImagePickerController alloc] init];
//    picker.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    picker.delegate=self;
//    [self presentModalViewController:picker animated:YES];
//}
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissModalViewControllerAnimated:YES];
//}
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
//{
//    rootImageView.image = image;
//    [self dismissModalViewControllerAnimated:YES];
//}

@end

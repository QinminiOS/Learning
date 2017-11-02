//
//  ViewController.m
//  NesSimulator
//
//  Created by qinmin on 2017/6/17.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"
#import "InfoNESHelper.h"
#import "JoyStickView.h"
#import "AudioPlayer.h"

NSString* const QMFrameReadyNotification = @"QMFrameReadyNotification";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (nonatomic, strong) IBOutlet JoyStickView *joystick;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleJoyStickNotification:) name:JoyStickChangeNotification object:nil];
    
    NSString *nesPath = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"nes"];
    [[InfoNESHelper sharedInstance] loadNesAndStart:nesPath];
    [[InfoNESHelper sharedInstance] setFrameCallback:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView.image = image;
        });
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)handleJoyStickNotification:(NSNotification *)notice
{
    CGPoint point = [notice.userInfo[@"DIR"] CGPointValue];
    NSLog(@"%@", NSStringFromCGPoint(point));
    
    if (CGPointEqualToPoint(point, CGPointZero)) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateNone];
    }else {
        // Left
        if (point.x <= -0.707) {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateLeftDown];
        }else {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateLeftUp];
        }
        
        // Right
        if (point.x >= 0.707) {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateRightDown];
        }else {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateRightUp];
        }
        
        // Top
        if (point.y <= -0.707) {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateTopDown];
        }else {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateTopUp];
        }
        
        // Bottom
        if (point.y >= 0.707) {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateBottomDown];
        }else {
            [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateBottomUp];
        }
    }
}

- (IBAction)optionButtonTapped:(UIButton *)sender
{
    NSLog(@"touch 1");
    
    if (sender.tag == 1) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateSelectDown];
    }else if(sender.tag == 2) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateStartDown];
    }else if (sender.tag == 3) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateADown];
    }else if(sender.tag == 4) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateBDown];
    }
}

- (IBAction)optionButtonTouchEnd:(UIButton *)sender
{
    NSLog(@"touch 2");
    
    if (sender.tag == 1) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateSelectUp];
    }else if(sender.tag == 2) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateStartUp];
    }else if (sender.tag == 3) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateAUp];
    }else if(sender.tag == 4) {
        [[InfoNESHelper sharedInstance] setKeyState:InfoNesKeyStateBUp];
    }
}

@end

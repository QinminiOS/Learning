//
//  InfoNESHelper.h
//  NesSimulator
//
//  Created by qinmin on 2017/6/18.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, InfoNesKeyState) {
    InfoNesKeyStateNone = 0,
    InfoNesKeyStateLeftDown ,
    InfoNesKeyStateLeftUp,
    InfoNesKeyStateRightDown,
    InfoNesKeyStateRightUp,
    InfoNesKeyStateTopDown,
    InfoNesKeyStateTopUp,
    InfoNesKeyStateBottomDown,
    InfoNesKeyStateBottomUp,
    InfoNesKeyStateStartDown,
    InfoNesKeyStateStartUp,
    InfoNesKeyStateSelectDown,
    InfoNesKeyStateSelectUp,
    InfoNesKeyStateADown,
    InfoNesKeyStateAUp,
    InfoNesKeyStateBDown,
    InfoNesKeyStateBUp,
};

@interface InfoNESHelper : NSObject
// For InfoNES
@property (nonatomic, assign, readonly) unsigned long padVaule;
@property (nonatomic, strong, readonly) void(^frameLoadCallback)(UIImage *image);

// For Render
@property (nonatomic, strong) void(^frameCallback)(UIImage *image);

+ (instancetype)sharedInstance;

- (void)loadNesAndStart:(NSString *)path;

- (void)setKeyState:(InfoNesKeyState)state;

- (UIImage *)convertRGB565ToUIImage:(unsigned short *)rgb565 width:(int)w height:(int)h;

- (void)playAudio:(unsigned char *)data length:(int64_t)length;

@end

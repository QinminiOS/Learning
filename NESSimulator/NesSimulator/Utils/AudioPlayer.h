//
//  AudioPlayer.h
//  NesSimulator
//
//  Created by qinmin on 2017/6/17.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioPlayer : NSObject

+ (instancetype)sharedAudioPlayer;

// 播放并顺带附上数据
- (void)playWithData:(NSData *)data;

// reset
- (void)resetPlay;

@end

//
//  OpenALPlayer.h
//  NesSimulator
//
//  Created by qinmin on 2017/7/28.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenALPlayer : NSObject

- (void)intOpenAL;

- (void)openAudioFromQueue:(unsigned char*)data dataSize:(int64_t)dataSize;
- (BOOL)updataQueueBuffer;

- (void)playSound;
- (void)stopSound;

- (void)cleanUpOpenAL;

@end

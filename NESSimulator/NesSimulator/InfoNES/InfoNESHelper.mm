//
//  InfoNESHelper.m
//  NesSimulator
//
//  Created by qinmin on 2017/6/18.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "InfoNESHelper.h"
#import "libyuv.h"
#import "QMImageHelper.h"
#import "InfoNES_System.h"
#import "AudioPlayer.h"
#import "OpenALPlayer.h"

static unsigned long setbits(unsigned long x, int p, int n, unsigned y)
{
    int mask;
    int pos=p+1-n;
    mask=~(~0<<n) << pos ;
    x=x & ~mask;
    y=y<<pos & mask;
    x=x|y;
    return x;
}

@interface InfoNESHelper()
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, strong) OpenALPlayer *player;
@end

@implementation InfoNESHelper

+ (instancetype)sharedInstance
{
    static InfoNESHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)loadNesAndStart:(NSString *)path
{
    _player = [[OpenALPlayer alloc] init];
    [_player intOpenAL];

    __weak typeof(self) wSelf = self;
    _frameLoadCallback = ^(UIImage *image) {
        __strong typeof(self) sSelf = wSelf;
        if (sSelf.frameCallback) {
            sSelf.frameCallback(image);
        }
        
        NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval deltaTime = nowTime - _lastTime;
        NSLog(@"%0.3f", deltaTime); // 0.016
        
//        if (deltaTime < 0.016) {
//            [NSThread sleepForTimeInterval:(0.012f)];
//        }
        
        _lastTime = [[NSDate date] timeIntervalSince1970];
    };
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        iOSMain(path.UTF8String);
    });
}

- (void)setKeyState:(InfoNesKeyState)state
{
    switch (state) {
        case InfoNesKeyStateADown:
            _padVaule = setbits(_padVaule, 0, 1, 1);
            break;
        case InfoNesKeyStateAUp:
            _padVaule = setbits(_padVaule, 0, 1, 0);
            break;
        case InfoNesKeyStateBDown:
            _padVaule = setbits(_padVaule, 1, 1, 1);
            break;
        case InfoNesKeyStateBUp:
            _padVaule = setbits(_padVaule, 1, 1, 0);
            break;
        case InfoNesKeyStateSelectDown:
            _padVaule = setbits(_padVaule, 2, 1, 1);
            break;
        case InfoNesKeyStateSelectUp:
            _padVaule = setbits(_padVaule, 2, 1, 0);
            break;
        case InfoNesKeyStateStartDown:
            _padVaule = setbits(_padVaule, 3, 1, 1);
            break;
        case InfoNesKeyStateStartUp:
            _padVaule = setbits(_padVaule, 3, 1, 0);
            break;
        case InfoNesKeyStateLeftDown:
            _padVaule = setbits(_padVaule, 6, 1, 1);
            break;
        case InfoNesKeyStateLeftUp:
            _padVaule = setbits(_padVaule, 6, 1, 0);
            break;
        case InfoNesKeyStateRightDown:
            _padVaule = setbits(_padVaule, 7, 1, 1);
            break;
        case InfoNesKeyStateRightUp:
            _padVaule = setbits(_padVaule, 7, 1, 0);
            break;
        case InfoNesKeyStateTopDown:
            _padVaule = setbits(_padVaule, 4, 1, 1);
            break;
        case InfoNesKeyStateTopUp:
            _padVaule = setbits(_padVaule, 4, 1, 0);
            break;
        case InfoNesKeyStateBottomDown:
            _padVaule = setbits(_padVaule, 5, 1, 1);
            break;
        case InfoNesKeyStateBottomUp:
            _padVaule = setbits(_padVaule, 5, 1, 0);
            break;
        default:
            _padVaule = 0;
            break;
    }
    
//    _padVaule = ( A ) |  /* A */
//    ( B << 1 ) |  /* B */
//    ( select << 2 ) |  /* Select */
//    ( start << 3 ) |  /* Start */
//    ( top << 4 ) |  /* Up */
//    ( bottom << 5 ) |  /* Down */
//    ( left << 6 ) |  /* Left */
//    ( right << 7 );   /* Right */
}

- (UIImage *)convertRGB565ToUIImage:(unsigned short *)rgb565 width:(int)w height:(int)h
{
    uint8 *argb = (uint8 *)malloc(sizeof(uint8) * w * h * 4);
    uint8 *bgra = (uint8 *)malloc(sizeof(uint8) * w * h * 4);
    libyuv::RGB565ToARGB((const uint8*)rgb565, w * 2, argb, w * 4, w, h);
    libyuv::ARGBToABGR(argb, w * 4, bgra, w * 4, w, h);
    
    UIImage *image = [QMImageHelper convertBitmapRGBA8ToUIImage:bgra withWidth:w withHeight:h];
    
    free(argb);
    free(bgra);
    return image;
}

- (void)playAudio:(unsigned char *)data length:(int64_t)length
{
    //static FILE *fileHandle = fopen("/Users/qinmin/Desktop/1.pcm", "ab+");
    //fwrite(data, 1, length, fileHandle);
    
    [[AudioPlayer sharedAudioPlayer] playWithData:[NSData dataWithBytes:data length:length]];
    
    //[_player openAudioFromQueue:data dataSize:length];
}

@end

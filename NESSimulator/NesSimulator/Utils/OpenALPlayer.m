//
//  OpenALPlayer.m
//  NesSimulator
//
//  Created by qinmin on 2017/7/28.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "OpenALPlayer.h"
#import <OpenAL/OpenAL.h>
#import <AudioToolbox/AudioToolbox.h>
#import <pthread.h>

@interface OpenALPlayer ()
{
    ALuint _outSourceId;
 
    dispatch_semaphore_t _semaphoreLock;
}
@property (nonatomic) ALCcontext *mContext;
@property (nonatomic) ALCdevice *mDevice;
@end

@implementation OpenALPlayer

- (instancetype)init
{
    if (self = [super init]) {
        _semaphoreLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)intOpenAL
{
    _mDevice = alcOpenDevice(NULL);
    if (_mDevice) {
        _mContext = alcCreateContext(_mDevice, NULL);
        alcMakeContextCurrent(_mContext);
    }
    
    alGenSources(1, &_outSourceId);
    alSpeedOfSound(1.0);
    
    alDopplerVelocity(1.0);
    alDopplerFactor(1.0);
    alSourcef(_outSourceId, AL_PITCH, 1.0f);
    alSourcef(_outSourceId, AL_GAIN, 1.0f);
    alSourcei(_outSourceId, AL_LOOPING, AL_FALSE);
    alSourcef(_outSourceId, AL_SOURCE_TYPE, AL_STREAMING);
}

- (void)openAudioFromQueue:(unsigned char*)data dataSize:(int64_t)dataSize
{
    dispatch_semaphore_wait(_semaphoreLock, DISPATCH_TIME_FOREVER);
    
    ALuint bufferID;
    alGenBuffers(1, &bufferID);
    NSMutableData *pcmData = [NSMutableData dataWithBytes:data length:dataSize];
    
    alBufferData(bufferID, AL_FORMAT_MONO8, (unsigned char *)pcmData.bytes, (ALsizei)pcmData.length, 22050);
    alSourceQueueBuffers(_outSourceId, 1, &bufferID);
    
    [self updataQueueBuffer];
    
    dispatch_semaphore_signal(_semaphoreLock);
}

- (BOOL)updataQueueBuffer
{
    ALint stateVaue;
    ALint processed = 0, queued = 0;
    
    alGetSourcei(_outSourceId, AL_BUFFERS_PROCESSED, &processed);
    alGetSourcei(_outSourceId, AL_BUFFERS_QUEUED, &queued);
    alGetSourcei(_outSourceId, AL_SOURCE_STATE, &stateVaue);
    
    if (stateVaue == AL_STOPPED || stateVaue == AL_PAUSED || stateVaue == AL_INITIAL) {
        if (queued < processed || queued == 0 ||(queued == 1 && processed == 1)) {
             NSLog(@"Audio Stop");
            //[self stopSound];
            //[self cleanUpOpenAL];
        }
       
        [self playSound];
        return NO;
    }
    
    alGetSourcei(_outSourceId , AL_BUFFERS_PROCESSED ,&processed);
    while (processed--) {
        ALuint buffer;
        alSourceUnqueueBuffers(_outSourceId, 1, &buffer);
        alDeleteBuffers(1, &buffer);
    }
    
    alGetSourcei(_outSourceId , AL_BUFFERS_QUEUED , &queued);
    while (queued--) {
        ALuint buffer = 0;
        alSourceUnqueueBuffers(_outSourceId ,1, &buffer);
        alDeleteBuffers(1 , &buffer);
    }
    return YES;
}

#pragma make - play/stop/clean function
- (void)playSound
{
    ALint stateVaue;
    alGetSourcei(_outSourceId, AL_SOURCE_STATE, &stateVaue);
    if (stateVaue == AL_STOPPED || stateVaue == AL_PAUSED || stateVaue == AL_INITIAL) {
        alSourcePlay(_outSourceId);
    }
}

- (void)stopSound
{
    ALint stateVaue;
    alGetSourcei(_outSourceId, AL_SOURCE_STATE, &stateVaue);
    if (stateVaue == AL_PLAYING) {
        alSourceStop(_outSourceId);
    }
}

- (void)cleanUpOpenAL
{
    alDeleteSources(1, &_outSourceId);
    alcDestroyContext(_mContext);
    alcCloseDevice(_mDevice);
    
}

@end

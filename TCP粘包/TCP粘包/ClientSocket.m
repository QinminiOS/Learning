//
//  ClientSocket.m
//  TCP粘包
//
//  Created by qinmin on 2017/11/5.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ClientSocket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

#define kMAXLINE    4096

static void* clientSocketSendQueueKey;
static void* clientSocketRecvQueueKey;

@interface ClientSocket()
{
    int                 _sockfd;
    NSString            *_serverIP;
    NSInteger           _serverPort;
    dispatch_queue_t    _clientSocketSendQueue;
    dispatch_queue_t    _clientSocketRecvQueue;
    BOOL                _isStop;
}
@end

@implementation ClientSocket

#pragma mark - LiferCycle
- (instancetype)initWithServerIP:(NSString *)IP port:(NSInteger)port
{
    if (self = [super init]) {
        _serverIP = IP;
        _serverPort = port;
        _isStop = YES;
        _clientSocketSendQueue = dispatch_queue_create("client.socket.send.queue", NULL);
        _clientSocketRecvQueue = dispatch_queue_create("client.socket.recv.queue", NULL);
        dispatch_queue_set_specific(_clientSocketSendQueue, &clientSocketSendQueueKey, NULL, NULL);
        dispatch_queue_set_specific(_clientSocketSendQueue, &clientSocketRecvQueueKey, NULL, NULL);
    }
    
    return self;
}

#pragma mark - PublicMethod
- (void)startConnect
{
    if (!_isStop) {
        return;
    }
    
    dispatch_block_t block = ^() {
        _isStop = NO;
        [self createClientSocket];
    };
    
    if (dispatch_queue_get_specific(_clientSocketSendQueue, &clientSocketSendQueueKey)) {
        dispatch_sync(_clientSocketSendQueue, block);
    }else {
        dispatch_async(_clientSocketSendQueue, block);
    }
}

- (void)stopConnect
{
    if (_isStop) {
        return;
    }
    
    dispatch_block_t block = ^() {
        close(_sockfd);
        _isStop = YES;
    };
    
    if (dispatch_queue_get_specific(_clientSocketSendQueue, &clientSocketSendQueueKey)) {
        dispatch_sync(_clientSocketSendQueue, block);
    }else {
        dispatch_async(_clientSocketSendQueue, block);
    }
}

- (void)sendData:(NSData *)data
{
    dispatch_block_t block = ^() {
        const char *sendLine = data.bytes;
        NSUInteger lineLength = (data.length > kMAXLINE ? kMAXLINE : data.length);
        ssize_t len = 0;
        while (!_isStop && (len = send(_sockfd, sendLine, lineLength, 0)) > 0) {
            sendLine += lineLength;
            NSUInteger left = data.length - lineLength;
            if (left <= 0) {
                break;
            }
            
            lineLength = (left > kMAXLINE ? kMAXLINE : left);
        }
        
        if (len < 0) {
            NSLog(@"send msg error: %s", strerror(errno));
        }
    };
    
    if (dispatch_queue_get_specific(_clientSocketSendQueue, &clientSocketSendQueueKey)) {
        dispatch_sync(_clientSocketSendQueue, block);
    }else {
        dispatch_async(_clientSocketSendQueue, block);
    }
}

- (void)recvData
{
    dispatch_block_t block = ^() {
        char buff[kMAXLINE];
        size_t n = 0;
        while (!_isStop && (n = recv(_sockfd, buff, kMAXLINE, 0)) > 0) {
            buff[n] = '\0';
            // NSLog(@"recv msg from client: %s\n", buff);
            NSLog(@"recv msg from client length: %ld", n);
            
            if (_clientDidRecvDataBlock) {
                _clientDidRecvDataBlock([NSData dataWithBytes:buff length:n]);
            }
        }
    };
    
    if (dispatch_queue_get_specific(_clientSocketRecvQueue, &clientSocketRecvQueueKey)) {
        dispatch_sync(_clientSocketRecvQueue, block);
    }else {
        dispatch_async(_clientSocketRecvQueue, block);
    }
}

#pragma mark - PrivateMethod
- (void)createClientSocket
{
    struct sockaddr_in servaddr;
    
    if((_sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        NSLog(@"socket error: %s", strerror(errno));
        return;
    }
    
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(_serverPort);
    if(inet_pton(AF_INET, _serverIP.UTF8String, &servaddr.sin_addr) <= 0) {
        NSLog(@"inet_pton error");
        return;
    }
    
    if(connect(_sockfd, (struct sockaddr*)&servaddr, sizeof(servaddr)) < 0) {
        NSLog(@"connect error: %s",strerror(errno));
        return;
    }
}

@end

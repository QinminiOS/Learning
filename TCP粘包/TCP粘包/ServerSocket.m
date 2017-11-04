//
//  ServerSocket.m
//  TCP粘包
//
//  Created by qinmin on 2017/11/5.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ServerSocket.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

#define kMAXLINE                 4096

@interface ServerSocket()
{
    int         _socketHandle;
    BOOL        _isFinish;
    NSInteger   _serverPort;
}
@end

@implementation ServerSocket

#pragma mark - LiferCycle
- (instancetype)initWithPort:(NSInteger)port
{
    if (self = [super init]) {
        _isFinish = YES;
        _serverPort = port;
    }
    
    return self;
}

#pragma mark - PublicMethod
- (void)startServer
{
    if (!_isFinish) {
        return;
    }
    
    _isFinish = NO;
    if ([NSThread isMainThread]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self createServerSocket];
        });
    }else {
        [self createServerSocket];
    }
}

- (void)stopServer
{
    if (_isFinish) {
        return;
    }
    
    _isFinish = YES;
    close(_socketHandle);
    
    if (_serverDidStopBlock) {
        _serverDidStopBlock();
    }
}

#pragma mark - PrivateMethod
- (void)createServerSocket
{
    int connnectHandle;
    struct sockaddr_in servaddr;
    char buff[kMAXLINE];
    
    if ((_socketHandle = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        NSLog(@"socket error %s", strerror(errno));
        return;
    }
    
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(_serverPort);
    
    if(bind(_socketHandle, (struct sockaddr*)&servaddr, sizeof(servaddr)) == -1) {
        NSLog(@"bind error: %s",strerror(errno));
        return;
    }
    
    if(listen(_socketHandle, 10) == -1) {
        NSLog(@"listen error: %s",strerror(errno));
        return;
    }
    
    if (_serverDidStartBlock) {
        _serverDidStartBlock();
    }
    
    // 目前只处理一个socket连接
    if((connnectHandle = accept(_socketHandle, (struct sockaddr*)NULL, NULL)) == -1) {
        NSLog(@"accept socket error: %s",strerror(errno));
        return;
    }
    
    size_t n;
    while (!_isFinish && (n = recv(connnectHandle, buff, kMAXLINE, 0)) > 0) {
        buff[n] = '\0';
//        NSLog(@"recv msg from client: %s\n", buff);
        NSLog(@"recv msg from client length: %ld", n);
    }
    close(connnectHandle);
}

@end

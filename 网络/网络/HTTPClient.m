//
//  HTTP.m
//  网络
//
//  Created by qinmin on 2017/10/15.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "HTTPClient.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

NSString* const HTTPLineBreak = @"\r\n";
NSString* const HTTPVersion = @"HTTP/1.1";

#define kHTTPMaxPacketSize        4096
#define kHTTPClientErrorDomain    @"HTTPClientErrorDomain"

@interface HTTPClient()
{
    dispatch_queue_t    _httpSendQueue;
    dispatch_queue_t    _httpRecvQueue;
    int                 _socketHandler;
}
@end

@implementation HTTPClient

- (void)dealloc
{
    close(_socketHandler);
}

- (instancetype)init
{
    if (self = [super init]) {
        _httpRecvQueue = dispatch_queue_create("com.httpclient.http.recv.queue", NULL);
        _httpSendQueue = dispatch_queue_create("com.httpclient.http.send.queue", NULL);
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL
{
    if (self = [self init]) {
        _URL = URL;
    }
    
    return self;
}

- (void)connect
{
    NSMutableString *httpContents = [NSMutableString string];
    [httpContents appendString:[self buildProtocol]];
    [httpContents appendString:[self buildHTTPHeader]];
    [httpContents appendString:[self buildHTTPBody]];
    [httpContents appendString:HTTPLineBreak];
    
    [self buildSocket];
    
    dispatch_async(_httpSendQueue, ^{
        [self sendStream:[httpContents dataUsingEncoding:NSUTF8StringEncoding]];
    });
    
    dispatch_async(_httpRecvQueue, ^{
        [self receiveStream];
    });
}

- (void)close
{
    close(_socketHandler);
    if ([_delegate respondsToSelector:@selector(HTTPClientDidClose:)]) {
        [_delegate HTTPClientDidClose:self];
    }
}

- (void)buildSocket
{
    if((_socketHandler = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
        // printf("create socket error: %s(errno: %d)\n", strerror(errno), errno);
        if ([_delegate respondsToSelector:@selector(HTTPClient:didFailWithError:)]) {
            NSDictionary *info = @{NSLocalizedDescriptionKey : [NSString stringWithUTF8String:strerror(errno)]};
            NSError *error = [NSError errorWithDomain:kHTTPClientErrorDomain code:errno userInfo:info];
            [_delegate HTTPClient:self didFailWithError:error];
        }
    }
    
    struct sockaddr_in servaddr;
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(80);
    inet_pton(AF_INET, "14.215.177.38", &servaddr.sin_addr);
    
    if ([_delegate respondsToSelector:@selector(HTTPClientWillConnect:)]) {
        [_delegate HTTPClientWillConnect:self];
    }
    
    if(connect(_socketHandler, (struct sockaddr*)&servaddr, sizeof(servaddr)) < 0) {
        // printf("connect error: %s(errno: %d)\n",strerror(errno), errno);
        if ([_delegate respondsToSelector:@selector(HTTPClient:didFailWithError:)]) {
            NSDictionary *info = @{NSLocalizedDescriptionKey : [NSString stringWithUTF8String:strerror(errno)]};
            NSError *error = [NSError errorWithDomain:kHTTPClientErrorDomain code:errno userInfo:info];
            [_delegate HTTPClient:self didFailWithError:error];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(HTTPClientDidConnect:)]) {
        [_delegate HTTPClientDidConnect:self];
    }
}

- (void)sendStream:(NSData *)data
{
    if ([_delegate respondsToSelector:@selector(HTTPClientWillSendData:)]) {
        [_delegate HTTPClientWillSendData:self];
    }
    
    NSUInteger length = data.length;
    const char *dataPtr = data.bytes;
    NSInteger sendSize = MIN(length, kHTTPMaxPacketSize);
    
    while (length > 0) {
        if(send(_socketHandler, dataPtr, sendSize, 0) < 0) {
            if ([_delegate respondsToSelector:@selector(HTTPClient:didFailWithError:)]) {
                NSDictionary *info = @{NSLocalizedDescriptionKey : [NSString stringWithUTF8String:strerror(errno)]};
                NSError *error = [NSError errorWithDomain:kHTTPClientErrorDomain code:errno userInfo:info];
                [_delegate HTTPClient:self didFailWithError:error];
            }
            
            [self close];
            return;
        }
    
        dataPtr += sendSize;
        length = length - sendSize;
        sendSize = MIN(length, kHTTPMaxPacketSize);
    }
    
    if ([_delegate respondsToSelector:@selector(HTTPClientFinishSendData:)]) {
        [_delegate HTTPClientFinishSendData:self];
    }
}

- (void)receiveStream
{
    ssize_t recLen;
    char buffer[kHTTPMaxPacketSize];
    while ((recLen = recv(_socketHandler, buffer, kHTTPMaxPacketSize, 0)) > 0) {
        buffer[recLen]  = '\0';
        //printf("Received : %s ", buffer);
        if ([_delegate respondsToSelector:@selector(HTTPClient:didRecvData:)]) {
            [_delegate HTTPClient:self didRecvData:[NSData dataWithBytes:buffer length:recLen]];
        }
    }
    
    if (recLen == -1) {
        if ([_delegate respondsToSelector:@selector(HTTPClient:didFailWithError:)]) {
            NSDictionary *info = @{NSLocalizedDescriptionKey : [NSString stringWithUTF8String:strerror(errno)]};
            NSError *error = [NSError errorWithDomain:kHTTPClientErrorDomain code:errno userInfo:info];
            [_delegate HTTPClient:self didFailWithError:error];
        }
    }
    
    [self close];
}

// GET / HTTP/1.1\r\n
- (NSString *)buildProtocol
{
    NSString *method = @"GET";
    
    switch (_method) {
        case HTTPMethodPOST:
            method = @"POST";
            break;
        case HTTPMethodGET:
            method = @"GET";
            break;
        case HTTPMethodPUT:
            method = @"PUT";
            break;
        case HTTPMethodHEAD:
            method = @"HEAD";
            break;
        case HTTPMethodDELETE:
            method = @"DELETE";
            break;
        default:
            break;
    }

    return [NSString stringWithFormat:@"%@ %@ %@%@", method, _URL.absoluteString, HTTPVersion, HTTPLineBreak];
}

- (NSString *)buildHTTPHeader
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[HTTPHeaderHost] = _URL.host;
    dict[HTTPHeaderUserAgent] = @"HTTPClient/1.0.0 (Macintosh; OS X/10.12.6) HTTPRequest";
    
    NSMutableString *header = [NSMutableString string];
    for (NSString *key in dict) {
        [header appendFormat:@"%@: %@%@", key, dict[key], HTTPLineBreak];
    }
    
    return [header copy];
}

- (NSString *)buildHTTPBody
{
    return @"";
}

@end

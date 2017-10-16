//
//  HTTP.h
//  网络
//
//  Created by qinmin on 2017/10/15.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPHeader.h"
#import "HTTPBody.h"

extern NSString* _Nonnull const HTTPLineBreak;
extern NSString* _Nonnull const HTTPVersion;

typedef NS_ENUM(NSInteger ,HTTPMethod) {
    HTTPMethodPOST,
    HTTPMethodGET,
    HTTPMethodPUT,
    HTTPMethodDELETE,
    HTTPMethodHEAD
};

@class HTTPClient;
@protocol HTTPClientProtocol <NSObject>
- (void)HTTPClientWillConnect:(HTTPClient *_Nonnull)client;
- (void)HTTPClientDidConnect:(HTTPClient *_Nonnull)client;
- (void)HTTPClientWillSendData:(HTTPClient *_Nonnull)client;
- (void)HTTPClientFinishSendData:(HTTPClient *_Nonnull)client;
- (void)HTTPClient:(HTTPClient *_Nonnull)client didFailWithError:(NSError *_Nullable)error;
- (void)HTTPClient:(HTTPClient *_Nonnull)client didRecvData:(NSData *_Nullable)data;
- (void)HTTPClientDidClose:(HTTPClient *_Nonnull)client;
@end

@interface HTTPClient : NSObject
@property (nonatomic, assign) HTTPMethod method;
@property (nonnull, nonatomic, assign) NSURL *URL;
@property (nullable, nonatomic, assign) HTTPHeader *header;
@property (nullable, nonatomic, assign) HTTPBody *body;
@property (nullable, nonatomic, weak) id<HTTPClientProtocol> delegate;
- (_Nonnull instancetype)initWithURL:(nonnull NSURL *)URL;
- (void)connect;
@end

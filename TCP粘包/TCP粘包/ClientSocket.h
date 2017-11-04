//
//  ClientSocket.h
//  TCP粘包
//
//  Created by qinmin on 2017/11/5.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClientSocket : NSObject
@property (strong, nonatomic) void(^clientDidRecvDataBlock)(NSData *data);
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithServerIP:(NSString *)IP port:(NSInteger)port;

- (void)startConnect;
- (void)stopConnect;

- (void)sendData:(NSData *)data;
- (void)recvData;
@end

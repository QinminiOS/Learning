//
//  ServerSocket.h
//  TCP粘包
//
//  Created by qinmin on 2017/11/5.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerSocket : NSObject
@property (copy, nonatomic) void (^serverDidStartBlock)(void);
@property (copy, nonatomic) void (^serverDidStopBlock)(void);

- (instancetype)initWithPort:(NSInteger)port;

- (void)startServer;
- (void)stopServer;
@end

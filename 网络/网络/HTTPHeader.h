//
//  HTTPHeader.h
//  网络
//
//  Created by qinmin on 2017/10/15.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

// HTTPHeaderField
extern NSString* _Nonnull const HTTPHeaderHost;
extern NSString* _Nonnull const HTTPHeaderConnection;
extern NSString* _Nonnull const HTTPHeaderCookie;
extern NSString* _Nonnull const HTTPHeaderUserAgent;

@interface HTTPHeader : NSObject
@property (nullable, copy) NSDictionary<NSString *, NSString *> *allHTTPHeaderFields;
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nonnull NSString *)field;
@end

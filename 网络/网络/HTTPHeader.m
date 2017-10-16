//
//  HTTPHeader.m
//  网络
//
//  Created by qinmin on 2017/10/15.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "HTTPHeader.h"

NSString* const HTTPHeaderHost = @"Host";
NSString* const HTTPHeaderConnection = @"Connection";
NSString* const HTTPHeaderCookie = @"Cookie";
NSString* const HTTPHeaderUserAgent = @"User-Agent";

@implementation HTTPHeader

- (instancetype)init
{
    if (self = [super init]) {
        _allHTTPHeaderFields = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field
{
    
}

@end

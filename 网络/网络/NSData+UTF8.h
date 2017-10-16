//
//  NSData+UTF8.h
//  网络
//
//  Created by qinmin on 2017/10/15.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (UTF8)

+ (NSData *)replaceNoUTF8:(NSData *)data;

@end

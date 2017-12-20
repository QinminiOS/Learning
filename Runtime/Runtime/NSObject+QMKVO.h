//
//  NSObject+QMKVO.h
//  Runtime
//
//  Created by qinmin on 2017/12/20.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (QMKVO)

- (void)qm_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
@end

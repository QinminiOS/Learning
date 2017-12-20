//
//  NSObject+QMKVO.m
//  Runtime
//
//  Created by qinmin on 2017/12/20.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "NSObject+QMKVO.h"
#import <objc/message.h>
#import <objc/runtime.h>

static NSString * const kQMKVOClassPrefix = @"KVONotifying_";
static NSString * const kQMKVOUnvailableException = @"KVOUnvailableException";

@implementation NSObject (QMKVO)

static NSString* KeyPathFromSetter(SEL sel)
{
    return [[[NSStringFromSelector(sel) stringByReplacingOccurrencesOfString:@"set" withString:@""] lowercaseString] stringByReplacingOccurrencesOfString:@":" withString:@""];
}

static SEL SetterFromKeyPath(NSString *keyPath)
{
    keyPath = [[keyPath stringByReplacingOccurrencesOfString:@"_" withString:@""] capitalizedString];
    NSString *sel = [[NSString alloc] initWithFormat:@"set%@:", keyPath];
    return NSSelectorFromString(sel);
}

static Class RegisterClass(Class superCls, NSString *name)
{
    Class cls = objc_allocateClassPair(superCls, name.UTF8String, 0);
    objc_registerClassPair(cls);
    return cls;
}

static void QMKVO_Setter_IMP(id target, SEL sel, id obj)
{
    NSString *old = [target valueForKeyPath:KeyPathFromSetter(sel)];
    
    struct objc_super supercls = {
        .receiver = target,
        .super_class = class_getSuperclass(object_getClass(target))
    };
    
    ((void (*)(void *, SEL, id))objc_msgSendSuper)(&supercls, sel, obj);
    
    NSString *new = [target valueForKeyPath:KeyPathFromSetter(sel)];
    
//    NSString *ivarName = [[NSString alloc] initWithFormat:@"_%@", KeyPathFromSetter(sel)];
//    Ivar ivar = class_getInstanceVariable([target class], ivarName.UTF8String);
//    object_setIvar(target, ivar, obj);
//    NSString *new = [target valueForKeyPath:KeyPathFromSetter(sel)];
    
    if ([target respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]) {
        NSDictionary *info = @{
                               NSKeyValueChangeNewKey : new ?: [NSNull null],
                               NSKeyValueChangeOldKey : old ?: [NSNull null]
                               };
        [target observeValueForKeyPath:KeyPathFromSetter(sel) ofObject:nil change:info context:nil];
    }
    
}

- (void)qm_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    Class superCls = object_getClass(self);
    SEL setter = SetterFromKeyPath(keyPath);
    
    Method setterMethod = class_getInstanceMethod([self class], setter);
    if (!setterMethod) {
        NSString *reason = [[NSString alloc] initWithFormat:@"Class <%@, %p> does't have a selector named %@", superCls, superCls, NSStringFromSelector(setter)];
        @throw [[NSException alloc] initWithName:kQMKVOUnvailableException reason:reason userInfo:nil];
    }
    
    Class newCls;
    if ([NSStringFromClass(superCls) containsString:kQMKVOClassPrefix]) {
        newCls = superCls;
    }else {
        NSString *clsName = [[NSString alloc] initWithFormat:@"%@%@", kQMKVOClassPrefix, NSStringFromClass(superCls)];
        newCls = RegisterClass(superCls, clsName);
        object_setClass(self, newCls);
    }
    
    BOOL success = class_addMethod(newCls, setter, (IMP)QMKVO_Setter_IMP, method_getTypeEncoding(setterMethod));
    
    if (!success) {
        Method method = class_getInstanceMethod(newCls, setter);
        IMP imp = method_getImplementation(method);
        
        if (imp != (IMP)QMKVO_Setter_IMP) {
            class_replaceMethod(newCls, setter, (IMP)QMKVO_Setter_IMP, method_getTypeEncoding(setterMethod));
        }
        
        NSLog(@"%@ have method %@", self, NSStringFromSelector(setter));
    }
}

@end

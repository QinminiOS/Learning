//
//  MainViewModel.m
//  RAC
//
//  Created by qinmin on 2017/11/2.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "MainViewModel.h"

@interface MainViewModel ()

@end

@implementation MainViewModel

- (instancetype)init
{
    if (self = [super init]) {
        RAC(self, loginState) = [[RACSignal combineLatest:@[RACObserve(self, name), RACObserve(self, age)]] map:^id _Nullable(RACTuple * _Nullable value) {
            NSString *name = value.first;
            NSString *age = value.second;
            if (name.length > 0 && age.length > 0) {
                return @1;
            }else if (name.length > 0) {
                return @2;
            }else if (age.length > 0) {
                return @3;
            }else {
                return @4;
            }
        }];
        
        @weakify(self);
        [RACObserve(self, loginState) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if ([x integerValue] != 1) {
                self.textString = @"";
            }
        }];
    }
    
    return self;
}

- (RACCommand *)loginCmd
{
    if (!_loginCmd) {
        _loginCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@"123"];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{
                    NSLog(@"loginCmd dispose");
                }];
            }];
            
        }];
        
        @weakify(self);
        [[_loginCmd.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            
            UIViewController *view = [[UIViewController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = view;
            
            self.textString = @"登录成功！！！！！！！！";
        }];
    }
    return _loginCmd;
}

@end

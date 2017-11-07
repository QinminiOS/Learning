//
//  MainViewModel.h
//  RAC
//
//  Created by qinmin on 2017/11/2.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

@interface MainViewModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *textString;
@property (assign, nonatomic) NSInteger loginState;
@property (strong, nonatomic) RACCommand *loginCmd;
@end

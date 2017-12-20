//
//  ViewController.m
//  Runtime
//
//  Created by qinmin on 2017/12/20.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+QMKVO.h"

@interface ViewController ()
@property (strong, nonatomic) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self qm_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [self qm_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
//    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//
//    [self willChangeValueForKey:@"name"];
//    _name = @"123";
//    [self didChangeValueForKey:@"name"];

    self.name = @"456";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@", change);
}

@end

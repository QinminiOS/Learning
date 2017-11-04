//
//  ViewController.m
//  TCP粘包
//
//  Created by qinmin on 2017/11/5.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"
#import "ServerSocket.h"
#import "ClientSocket.h"

@interface ViewController ()
@property (strong, nonatomic) ServerSocket *server;
@property (strong, nonatomic) ClientSocket *client;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo" ofType:@"txt"]];
    
//    NSLog(@"%ld", data.length);
    
    _client = [[ClientSocket alloc] initWithServerIP:@"127.0.0.1" port:6666];
    _server = [[ServerSocket alloc] initWithPort:6666];
    
    __weak typeof(self) wself = self;
    [_server setServerDidStartBlock:^{
        __strong typeof(self) sself = wself;
        [sself.client startConnect];
        [sself.client sendData:data];
        [sself.client sendData:data];
        [sself.client sendData:data];
        [sself.client sendData:data];
    }];
    
    [_server startServer];
}

@end

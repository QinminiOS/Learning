//
//  ViewController.m
//  网络
//
//  Created by qinmin on 2017/10/10.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"
#import "HTTPClient.h"
#import "NSData+UTF8.h"

#define MAXLINE 4096

@interface ViewController () <HTTPClientProtocol>
{
    NSOperationQueue *_queue;
    HTTPClient *_httpClient;
    
    NSMutableData *_data;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _data = [NSMutableData data];
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/?name=123&pwd=456"];
    
    _httpClient = [[HTTPClient alloc] initWithURL:url];
    _httpClient.delegate = self;
    
    [_httpClient connect];
    
    
}

- (void)HTTPClient:(HTTPClient * _Nonnull)client didFailWithError:(NSError * _Nullable)error
{
    NSLog(@"%@", [error localizedDescription]);
}

- (void)HTTPClient:(HTTPClient * _Nonnull)client didRecvData:(NSData * _Nullable)data
{
    [_data appendData:[data copy]];
}

- (void)HTTPClientDidClose:(HTTPClient * _Nonnull)client
{
    NSLog(@"%s", __func__);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = [[NSMutableString alloc] initWithData:[NSData replaceNoUTF8:_data] encoding:NSUTF8StringEncoding];
    });
}

- (void)HTTPClientDidConnect:(HTTPClient * _Nonnull)client
{
    NSLog(@"%s", __func__);
}

- (void)HTTPClientFinishSendData:(HTTPClient * _Nonnull)client
{
    NSLog(@"%s", __func__);
}

- (void)HTTPClientWillConnect:(HTTPClient * _Nonnull)client
{
    NSLog(@"%s", __func__);
}

- (void)HTTPClientWillSendData:(HTTPClient * _Nonnull)client
{
    NSLog(@"%s", __func__);
}


@end

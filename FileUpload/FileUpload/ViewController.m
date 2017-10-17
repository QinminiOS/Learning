//
//  ViewController.m
//  FileUpload
//
//  Created by qinmin on 2017/10/17.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self uploadFile];
}

- (void)uploadFile
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *uploadURL = @"http://192.168.3.235/upload_file.php";
    
//    // form-data request -> Content-Type: multipart/form-data
//    [manager POST:uploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"1.jpg" withExtension:nil];
//        [formData appendPartWithFileURL:url name:@"file" error:nil];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }];
    
//    // form-data request -> Content-Type: multipart/form-data
//    [manager POST:uploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"1.data" withExtension:nil];
//        [formData appendPartWithFileURL:url name:@"file" error:nil];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", [error localizedDescription]);
//    }];
    
    // urlencoded request -> Content-Type: application/x-www-form-urlencoded
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"1.jpg" withExtension:nil];
    [manager POST:uploadURL parameters:@{@"file":[NSData dataWithContentsOfURL:fileURL]} progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
    
//        // json request -> Content-Type: application/json
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [manager POST:uploadURL parameters:@{@"file":@"I am file"} progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@", [error localizedDescription]);
//        }];
}

@end

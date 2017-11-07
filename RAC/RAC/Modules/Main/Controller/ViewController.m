//
//  ViewController.m
//  RAC
//
//  Created by qinmin on 2017/10/31.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "MainViewModel.h"
#import <ReactiveObjC/RACmetamacros.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (strong, nonatomic) MainViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic) id<RACSubscriber> subscriber;
@property (strong, nonatomic) RACSignal *signal;
@property (strong, nonatomic) NSString *name;
@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@"123"];
        
        self.name = @"123";
        
        return [RACDisposable disposableWithBlock:^{
           NSLog(@"%@", @"我被释放了");
        }];
    }];

    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    self.signal = signal;
    
    // 事件
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        UIViewController *vc = [[UIViewController alloc] init];
        [[UIApplication sharedApplication] keyWindow].rootViewController = vc;
    }];
    
}

- (void)bindViewModel
{
    _viewModel = [[MainViewModel alloc] init];

    RAC(_viewModel, name) = _nameTextField.rac_textSignal;
    RAC(_viewModel, age) = _ageTextField.rac_textSignal;

    RAC(self.view, backgroundColor) = [self loginSateSignalToColorSignal:RACObserve(_viewModel, loginState)];

    RAC(_loginButton, enabled) = [RACObserve(_viewModel, loginState) map:^id _Nullable(id  _Nullable value) {
        switch ([value integerValue]) {
            case 1:
                return @YES;
                break;
            case 2:
                return @NO;
                break;
            case 3:
                return @NO;
                break;
            default:
                break;
        }
        return @NO;
    }];

    [self.loginButton setRac_command:self.viewModel.loginCmd];

    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.viewModel.loginCmd execute:@"qinmin"];
    }];

    RAC(self.textLabel, text) = RACObserve(self.viewModel, textString);

}

- (RACSignal *)loginSateSignalToColorSignal:(RACSignal *)loginSignal
{
    return [loginSignal map:^id _Nullable(id  _Nullable value) {
        switch ([value integerValue]) {
            case 1:
                return [UIColor redColor];
                break;
            case 2:
                return [UIColor greenColor];
                break;
            case 3:
                return [UIColor blueColor];
                break;
            default:
                return [UIColor whiteColor];
                break;
        }
    }];
}

@end

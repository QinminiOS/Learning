//
//  ViewController.m
//  手势识别
//
//  Created by qinmin on 2017/10/28.
//  Copyright © 2017年 qinmin. All rights reserved.
//

#import "ViewController.h"

NSString * const TableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface ViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *rectView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self test2OnView:_rectView];
}

/////////////////////// test1 ////////////////////////////////
- (void)test1OnView:(UIView *)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureRecognizerTrigger:)];
    tap.delegate = self;
    [view addGestureRecognizer:tap];

    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureRecognizerTrigger:)];
    press.delegate = self;
    [view addGestureRecognizer:press];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureRecognizerTrigger:)];
    swip.delegate = self;
    [view addGestureRecognizer:swip];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureRecognizerTrigger:)];
    pan.delegate = self;
    [view addGestureRecognizer:pan];
    
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureRecognizerTrigger:)];
    rotation.delegate = self;
    [view addGestureRecognizer:rotation];
    
}

- (void)onGestureRecognizerTrigger:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%@", [gestureRecognizer class]);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/////////////////// test2 ////////////////////////////
- (void)test2OnView:(UIView *)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureRecognizerTrigger:)];
    tap.delegate = self;
    tap.delegate = self;
    [view addGestureRecognizer:tap];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:view.bounds];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellReuseIdentifier];
    [view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellReuseIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"row = %ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAt index = %ld", indexPath.row);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return NO;
    }
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    
    return YES;
}

@end

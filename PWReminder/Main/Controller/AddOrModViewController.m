//
//  AddViewController.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "AddOrModViewController.h"
#import "AddOrModView.h"
#import "PublicHeader.h"

@interface AddOrModViewController()<AddOrModViewDelegate>
{
    AddOrModView *_addOrModView;
}
@end

@implementation AddOrModViewController
- (void)viewDidLoad
{
    [self addViews];
}

- (void)addViews
{
    _addOrModView = [[AddOrModView alloc] init];
    _addOrModView.delegate = self;
    [self.view addSubview:_addOrModView];
    
    [_addOrModView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma -mark AddOrModViewDelegate

- (void)didClickAccountTypeBtn
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择账户类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *bankCardAction = [UIAlertAction actionWithTitle:@"银行卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
    }];
    
    UIAlertAction *webAction = [UIAlertAction actionWithTitle:@"网站论坛" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
    }];
    
    UIAlertAction *socialNetworkAction = [UIAlertAction actionWithTitle:@"社交网络" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"社交网络" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
    }];
    
    
    [alertVC addAction:socialNetworkAction];
    [alertVC addAction:webAction];
    [alertVC addAction:bankCardAction];
    [alertVC addAction:otherAction];
    
    [alertVC addAction:cancelAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
@end

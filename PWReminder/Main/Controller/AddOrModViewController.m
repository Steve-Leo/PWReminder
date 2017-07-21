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
#import "AccountModel.h"
#import "DataManager.h"

@interface AddOrModViewController()<AddOrModViewDelegate>
{
    AddOrModView *_addOrModView;
}
@property (nonatomic, strong)AccountModel *accountModel;

@end

@implementation AddOrModViewController
- (instancetype)initWithAccountModel:(AccountModel *)model
{
    self = [super init];
    self.accountModel = model;
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [super viewWillAppear:animated];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
////    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
////    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    [self viewWillDisappear:animated];
//}

- (void)viewDidLoad
{
    [self addViews];
}

- (void)addViews
{
    _addOrModView = [[AddOrModView alloc] init];
    [_addOrModView setAccountModel:self.accountModel];
    _addOrModView.delegate = self;
    [self.view addSubview:_addOrModView];
    
    [_addOrModView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)saveData
{
    NSLog(@"保存数据");
}


#pragma mark- AddOrModViewDelegate

- (void)didClickAccountTypeBtn
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择账户类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *bankCardAction = [UIAlertAction actionWithTitle:@"银行卡" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
        self.accountModel.accountModelType = AccountModelTypeBankCard;
        [_addOrModView setAcountTypeTitle];
    }];
    
    UIAlertAction *webAction = [UIAlertAction actionWithTitle:@"网站论坛" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
        self.accountModel.accountModelType = AccountModelTypeWeb;
        [_addOrModView setAcountTypeTitle];
    }];
    
    UIAlertAction *socialNetworkAction = [UIAlertAction actionWithTitle:@"社交网络" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
        self.accountModel.accountModelType = AccountModelTypeSocialNetwork;
        [_addOrModView setAcountTypeTitle];
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"其他账号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"hello world");
        self.accountModel.accountModelType = AccountModelTypeOther;
        [_addOrModView setAcountTypeTitle];
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

#pragma mark- getter
- (AccountModel *)accountModel
{
    if (nil == _accountModel)
    {
        _accountModel = [[AccountModel alloc] init];
    }
    return _accountModel;
}

@end

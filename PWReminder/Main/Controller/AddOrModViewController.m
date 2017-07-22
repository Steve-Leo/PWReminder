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
    AccountModel    *_tempAccountModel;
}
@property (nonatomic, strong)AccountModel *accountModel;

@end

@implementation AddOrModViewController
- (instancetype)initWithAccountModel:(AccountModel *)model
{
    self = [super init];
    self.accountModel = model;
    _tempAccountModel = [model copy];
    
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

- (BOOL)isInputOrUpdate
{
    if (_tempAccountModel != nil)
    {
        if (_tempAccountModel.accountId == self.accountModel.accountId &&
            _tempAccountModel.account == self.accountModel.account &&
            _tempAccountModel.accountModelType == self.accountModel.accountModelType &&
            _tempAccountModel.name == self.accountModel.name &&
            _tempAccountModel.password == self.accountModel.password &&
            _tempAccountModel.remark == self.accountModel.remark)
        {
            return NO;
        }
        return YES;
    }
    if (self.accountModel.password.length != 0 && self.accountModel.name.length != 0)
    {
        return YES;
    }
    
    return NO;
}

- (void)saveData
{
    if (self.accountModel.accountModelType == 0)
    {
        self.accountModel.accountModelType = AccountModelTypeOther;
    }
    
    if (_tempAccountModel != nil)
    {
        [[DataManager shared] updateDataWithAccountModel:self.accountModel];

    }
    else
    {
        [[DataManager shared] insertDataWithAccountModel:self.accountModel];
    }
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

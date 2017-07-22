//
//  ViewController.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/16.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "AddOrModViewController.h"
#import "AccountCell.h"
#import "AccountModel.h"
#import "DataManager.h"

@interface MainViewController ()
{
    NSArray<NSString *> *_sectionTitle;
    NSMutableArray<NSMutableArray *>  *_accountArray;
}

@end

@implementation MainViewController
static NSString * const cellReuseableID = @"accontId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    _accountArray = nil;
    _accountArray = [[DataManager shared] queryAllData];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- UITableViewDelegate UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _accountArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accountArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseableID];
    if (cell == nil)
    {
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseableID];
//        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseableID addAccountModel:model];
    }
    AccountModel *model = _accountArray[indexPath.section][indexPath.row];
    [cell setAccountModel:model];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    AccountModel *model = [_accountArray[section] firstObject];
    switch (model.accountModelType) {
        case AccountModelTypeSocialNetwork: {
            return @"社交网络";
            break;
        }
        case AccountModelTypeWeb: {
            return @"网站论坛";
            break;
        }
        case AccountModelTypeBankCard: {
            return @"银行卡";
            break;
        }
        case AccountModelTypeOther: {
            return @"其他账号";
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountModel *model = _accountArray[indexPath.section][indexPath.row];
    AddOrModViewController *addVC = [[AddOrModViewController alloc] initWithAccountModel:model];
    [addVC setTitle:@"修改账号"];
    
    [self.navigationController pushViewController:addVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WS(weakself);
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"妞妞确定要删除这条信息？" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            AccountModel *model = _accountArray[indexPath.section][indexPath.row];
            [[DataManager shared] deleteDataWithAccountModel: model];
            [_accountArray[indexPath.section] removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark- NavigationBar
- (void)setNavigationBar
{
    self.title = @"Home";
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)leftBarButtonItemClick
{
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [settingVC setTitle:@"设置"];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)rightBarButtonItemClick
{
    AddOrModViewController *addVC = [[AddOrModViewController alloc] init];
    [addVC setTitle:@"添加账号"];
    [self.navigationController pushViewController:addVC animated:YES];
}

@end

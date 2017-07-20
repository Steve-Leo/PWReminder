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

@interface MainViewController ()
{
    NSArray<NSString *> *_sectionTitle;
}

@end

@implementation MainViewController
static NSString * const cellReuseableID = @"accontId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _sectionTitle = @[@"社交网络",@"网站论坛",@"银行卡",@"其他"];
    [self setNavigationBar];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark UITableViewDelegate UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseableID];
    if (cell == nil)
    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseableID];
        AccountModel *model = [[AccountModel alloc] init];
        model.accountModelType = AccountModelTypeBankCard;
        model.name = @"中国工商银行";
        model.password = @"123123";
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseableID addAccountModel:model];
//        cell.textLabel.text = [NSString stringWithFormat:@"Secton %ld Row %ld",(long)indexPath.section, (long)indexPath.row];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitle[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddOrModViewController *addVC = [[AddOrModViewController alloc] init];
    [addVC setTitle:@"修改账号"];
    
    [self.navigationController pushViewController:addVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}



#pragma -mark NavigationBar
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

//
//  ViewController.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/16.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "MainViewController.h"
#import "SettingViewController.h"
#import "AddOrModViewController.h"
#import "AccountCell.h"
#import "AccountModel.h"
#import "DataManager.h"
#import "PublicHeader.h"

@interface MainViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, UIViewControllerPreviewingDelegate>
{
    NSArray<NSString *> *_sectionTitle;
    NSMutableArray<NSMutableArray *>  *_accountArray;
}

@end

@implementation MainViewController
static NSString * const cellReuseableID = @"accontId";
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.tableView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"addOrMod_bg"].CGImage);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
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
    [self registerForPreviewingWithDelegate:self sourceView:cell];
    [cell setAccountModel:model];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    AccountModel *model = [_accountArray[section] firstObject];
//    switch (model.accountModelType) {
//        case AccountModelTypeSocialNetwork: {
//            return @"社交网络";
//            break;
//        }
//        case AccountModelTypeWeb: {
//            return @"网站论坛";
//            break;
//        }
//        case AccountModelTypeBankCard: {
//            return @"银行卡";
//            break;
//        }
//        case AccountModelTypeOther: {
//            return @"其他账号";
//            break;
//        }
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountModel *model = _accountArray[indexPath.section][indexPath.row];
    AddOrModViewController *addVC = [[AddOrModViewController alloc] initWithAccountModel:model];
    [addVC setTitle:@"账号详情"];
    
    [self.navigationController pushViewController:addVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AccountModel *model = [_accountArray[section] firstObject];
    return [self createHeaderViewWithAccountModelType:model.accountModelType];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0f;
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
            if (_accountArray[indexPath.section].count == 0)
            {
                NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
                [indexSet addIndex:indexPath.section];
                [_accountArray removeObjectAtIndex:indexPath.section];
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
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

- (UIView *)createHeaderViewWithAccountModelType:(AccountModelType )accountmodelType
{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = UIColorFromHex(0x1c1c1c);
    UIImageView *iconImageView = [[UIImageView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = UIColorFromHex(0xFF5A0F);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20.0f];
    
    [headView addSubview:iconImageView];
    [headView addSubview:titleLabel];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(headView);
        make.left.equalTo(iconImageView.right).offset(6.0f);
        make.centerY.equalTo(headView);
    }];
    
    [iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(10.0f);
        make.size.equalTo(CGSizeMake(36.0f, 36.0f));
        make.centerY.equalTo(headView);
    }];
    
    switch (accountmodelType) {
        case AccountModelTypeSocialNetwork:
        {
            iconImageView.image = [[UIImage imageNamed:@"socialNetwork"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            titleLabel.text = @"社交网络";
            break;
        }
        case AccountModelTypeWeb: {
            iconImageView.image = [[UIImage imageNamed:@"web"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            titleLabel.text = @"网站与应用";
            break;
        }
        case AccountModelTypeBankCard: {
            iconImageView.image = [[UIImage imageNamed:@"bankcard"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            titleLabel.text = @"银行卡号";
            break;
        }
        case AccountModelTypeOther: {
            iconImageView.image = [[UIImage imageNamed:@"other"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            titleLabel.text = @"其他账号";
            break;
        }
    }
    return headView;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"还没有数据哦，快存一条";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: UIColorFromHex(0x272727)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - peek的代理方法，轻按即可触发弹出vc
- (UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //通过[previewingContext sourceView]拿到对应的cell的数据；
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    // 用于显示预览的vc
    AccountModel *model = _accountArray[indexPath.section][indexPath.row];
    AddOrModViewController *addOrModVc = [[AddOrModViewController alloc] initWithAccountModel:model];
    [addOrModVc setTitle:@"账号详情"];
    return addOrModVc;
}
#pragma mark -  pop的代理方法，在此处可对将要进入的vc进行处理
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}

#pragma mark- NavigationBar
- (void)setNavigationBar
{
    self.title = @"Home";
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
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

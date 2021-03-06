//
//  SettingViewController.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "SettingViewController.h"
#import <MBProgressHUD.h>
#import "SettingView.h"
#import "PublicHeader.h"
@interface SettingViewController()<SettingViewDelegate>
{
    SettingView  *_settingView;
}
@end
@implementation SettingViewController
static NSString * const kPassword = @"loginPassword";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0x1c1c1c);
    [self addViews];
}

- (void)addViews
{
    _settingView = [[SettingView alloc] init];
    _settingView.delegate = self;
    [self.view addSubview:_settingView];
    
    [_settingView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -SettingViewDelegate
- (void)didClickComfirmButton
{
    NSString *theOldPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
    NSString *theNewPassword = [_settingView getTheNewPassword];
    if (theNewPassword == nil || theNewPassword.length == 0)
    {
        UIAlertController *emptyAlertController = [UIAlertController alertControllerWithTitle:@"密码是空的，改啥改" message:@"妞妞要用点心哦" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"妞妞傻瓜" style:UIAlertActionStyleDestructive handler:nil];
        [emptyAlertController addAction:sureAction];
        [self presentAlertController:emptyAlertController];
    }
    else
    {
        UIAlertController *modifyAlertController = [UIAlertController alertControllerWithTitle:@"妞妞确定要修改密码吗？" message:@"改了妞妞又不一定记得住，哼" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([theNewPassword isEqualToString:theOldPassword])
            {
                UIAlertController *theSameAlertController = [UIAlertController alertControllerWithTitle:@"跟旧密码一样，改啥改" message:@"唉，妞妞真是太蠢啦" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"妞妞最蠢" style:UIAlertActionStyleDestructive handler:nil];
                [theSameAlertController addAction:sureAction];
                [self presentAlertController:theSameAlertController];
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:theNewPassword forKey:kPassword];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"修改成功，即将退出";
                [self performSelector:@selector(ModifySuccess) withObject:nil afterDelay:0.5];
            }
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [modifyAlertController addAction:sureAction];
        [modifyAlertController addAction:cancelAction];
        [self presentAlertController:modifyAlertController];
    }
}

- (void)didClickUploadButton
{
    UIAlertController *theSameAlertController = [UIAlertController alertControllerWithTitle:@"没有钱，点了也没用" message:@"唉" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"哦" style:UIAlertActionStyleDestructive handler:nil];
    [theSameAlertController addAction:sureAction];
    [self presentAlertController:theSameAlertController];
}

- (void)didClickDownloadBtn
{
    UIAlertController *theSameAlertController = [UIAlertController alertControllerWithTitle:@"没有钱，点了也没用" message:@"唉" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"哦" style:UIAlertActionStyleDestructive handler:nil];
    [theSameAlertController addAction:sureAction];
    [self presentAlertController:theSameAlertController];
}

- (void)ModifySuccess
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)presentAlertController:(UIAlertController *)alertController
{
    [self presentViewController:alertController animated:YES completion:nil];
}
@end

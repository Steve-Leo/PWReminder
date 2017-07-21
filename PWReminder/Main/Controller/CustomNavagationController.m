//
//  CustomNavagationController.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "CustomNavagationController.h"
#import "AddOrModViewController.h"
#import "PublicHeader.h"
@implementation CustomNavagationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0)
    {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [backBtn setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backUIBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        [viewController.navigationItem setLeftBarButtonItem:backUIBarButtonItem];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popViewController
{
    UIViewController *VC = self.topViewController;
    if ([VC isKindOfClass:[AddOrModViewController class]])
    {
        AddOrModViewController *addOrModVC = (AddOrModViewController *)VC;
        UIAlertController *saveAlertController = [UIAlertController alertControllerWithTitle:@"是否保存" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [addOrModVC saveData];
            [self popViewControllerAnimated:YES];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self popViewControllerAnimated:YES];
        }];
        
        [saveAlertController addAction:saveAction];
        [saveAlertController addAction:cancelAction];
        [addOrModVC presentViewController:saveAlertController animated:YES completion:^{
            
        }];
    }
    else
    {
        [self popViewControllerAnimated:YES];
    }
}

@end

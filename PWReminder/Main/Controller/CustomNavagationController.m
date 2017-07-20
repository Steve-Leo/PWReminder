//
//  CustomNavagationController.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "CustomNavagationController.h"
#import "PublicHeader.h"
@implementation CustomNavagationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0)
    {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [backBtn setImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backUIBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        [viewController.navigationItem setLeftBarButtonItem:backUIBarButtonItem];
    }
    
    [super pushViewController:viewController animated:animated];
}
@end

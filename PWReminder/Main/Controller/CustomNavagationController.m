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

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationBar.layer.backgroundColor = UIColorFromHex(0xff4b3c).CGColor;
//    self.navigationBar.barTintColor = UIColorFromHex(0xA55A6C);
    
    self.navigationBar.barTintColor = [UIColor blackColor];
    NSDictionary *attributeDict = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:[UIFont fontWithName:@"PingFang SC" size:20.0]};
    [self.navigationBar setTitleTextAttributes:attributeDict];
    
    __weak CustomNavagationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
        
        self.delegate = (id)weakSelf;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0)
    {
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backUIBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        [viewController.navigationItem setLeftBarButtonItem:backUIBarButtonItem];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popViewController
{
    UIViewController *VC = self.topViewController;
    if ([VC isKindOfClass:[AddOrModViewController class]])
    {
        AddOrModViewController *addOrModVC = (AddOrModViewController *)VC;
        if ([addOrModVC isInputOrUpdate])
        {
            UIAlertController *saveAlertController = [UIAlertController alertControllerWithTitle:@"是否保存" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [addOrModVC saveData];
                [self popViewControllerAnimated:YES];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [self popViewControllerAnimated:YES];
            }];
            
            [saveAlertController addAction:saveAction];
            [saveAlertController addAction:cancelAction];
            [addOrModVC presentViewController:saveAlertController animated:YES completion:nil];
        }
        else
        {
            [self popViewControllerAnimated:YES];
        }
    }
    else
    {
        [self popViewControllerAnimated:YES];
    }
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
        if ([self.visibleViewController isKindOfClass:[AddOrModViewController class]])
        {
            AddOrModViewController *addOrModVC = (AddOrModViewController *)self.visibleViewController;
            if ([addOrModVC isInputOrUpdate])
            {
                [self popViewController];
                return NO;
            }
            else
            {
                return YES;
            }
        }
    }
    
    return YES;
}


@end

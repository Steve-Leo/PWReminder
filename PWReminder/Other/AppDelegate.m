//
//  AppDelegate.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/16.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <IQKeyboardManager.h>
#import "MainViewController.h"
#import "LoginViewController.h"
#import "CustomNavagationController.h"
#import "AppDelegate.h"
#import "PublicHeader.h"
@interface AppDelegate ()
@property (nonatomic, strong, nullable) UIVisualEffectView *visualEffectView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self fingerPrinterCheck];
    [NSThread sleepForTimeInterval:1.5];
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    MainViewController *mainVC = [[MainViewController alloc] init];
//    CustomNavagationController *cnvc = [[CustomNavagationController alloc] initWithRootViewController:mainVC];
    
    
    
    [self.window setTintColor:UIColorFromHex(0xE14F0C)];
//    [self.window setTintColor:[UIColor whiteColor]];
//    self.window.rootViewController = loginViewController;
    self.window.rootViewController = loginViewController;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [[IQKeyboardManager sharedManager] setToolbarTintColor:UIColorFromHex(0xE14F0C)];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.visualEffectView.alpha = 0;
    self.visualEffectView.frame = self.window.frame;
    [self.window addSubview:self.visualEffectView];
    [UIView animateWithDuration:0.3 animations:^{
        self.visualEffectView.alpha = 1.0;
    }];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    self.window.rootViewController = loginViewController;
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIView animateWithDuration:0.3 animations:^{
        self.visualEffectView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.visualEffectView removeFromSuperview];
    }];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

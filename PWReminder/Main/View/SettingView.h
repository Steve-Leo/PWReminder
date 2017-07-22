//
//  SettingView.h
//  PWReminder
//
//  Created by LeoSteve on 2017/7/21.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingViewDelegate<NSObject>

- (void)didClickComfirmButton;
- (void)didClickUploadButton;
- (void)didClickDownloadBtn;
@end



@interface SettingView : UIView
@property (nonatomic, weak)id<SettingViewDelegate> delegate;
- (NSString *)getTheNewPassword;
@end

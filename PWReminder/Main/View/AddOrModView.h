//
//  AddOrModView.h
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddOrModViewDelegate<NSObject>
- (void)didClickAccountTypeBtn;
@end

@interface AddOrModView : UIView
@property (nonatomic, weak)id<AddOrModViewDelegate> delegate;
@end

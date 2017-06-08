//
//  SettingViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/6/1.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "SettingViewController.h"
#import "NotificationViewController.h"
#import "GeneralViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupGroups];
}

#pragma mark - setup
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *account = [YJCommonItem itemWithTitle:@"账号管理" destVcClass:nil];
    group.items = @[account];
}

- (void)setupGroup1
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *notification = [YJCommonItem itemWithTitle:@"通知和提醒" destVcClass:[NotificationViewController class]];
    notification.badgevalue = @"6";
    YJCommonItem *secret = [YJCommonItem itemWithTitle:@"隐私与安全" destVcClass:nil];
    YJCommonItem *general = [YJCommonItem itemWithTitle:@"通用设置" destVcClass:[GeneralViewController class]];
    group.items = @[notification,secret,general];
}

- (void)setupGroup2
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *cache = [YJCommonItem itemWithTitle:@"清理缓存" destVcClass:nil];
    cache.defaultText = @"2M";
    [cache didClicked:^{
        NSLog(@"清理緩存");
    }];
    YJCommonItem *feedback = [YJCommonItem itemWithTitle:@"意见反馈" destVcClass:nil];
    group.items = @[cache,feedback];
}

@end

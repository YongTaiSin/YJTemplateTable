//
//  YJNotificationViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/5.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "NotificationViewController.h"

@implementation NotificationViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setupGroup0
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *receivePush = [YJCommonItem itemWithTitle:@"接收推送通知" destVcClass:nil];
    receivePush.text = @"已开启";
    group.footer = @"要开启或关闭微博的推送通知，请在iPhone的“设置”-“通知”中找到“微博”进行设置";
    group.items = @[receivePush];
}

- (void)setupGroup1
{
    YJCommonGroup *group = [self addGroup];
    
    YJCommonItem *mentionMe = [YJCommonItem itemWithTitle:@"@我的" destVcClass:nil];
    mentionMe.defaultText = @"所有人";
    
    YJCommonItem *comment = [YJCommonItem itemWithTitle:@"评论" destVcClass:nil];
    comment.defaultText = @"所有人";
    
    YJCommonItem *like = [YJCommonItem itemWithTitle:@"赞" destVcClass:nil];
    
    YJCommonItem *inbox = [YJCommonItem itemWithTitle:@"私信" type:CommonCellType_Switch];
    
    YJCommonItem *groupNotice = [YJCommonItem itemWithTitle:@"群通知" type:CommonCellType_Switch];
    
    YJCommonItem *unfocusInbox = [YJCommonItem itemWithTitle:@"未关注人私信" destVcClass:nil];
    unfocusInbox.defaultText = @"我关注的人";
    
    YJCommonItem *newfans = [YJCommonItem itemWithTitle:@"新粉丝" destVcClass:nil];
    newfans.defaultText = @"所有人";
    group.items = @[mentionMe,comment,like,inbox,groupNotice,unfocusInbox,newfans];
    
    group.header = @"新消息通知";
}

- (void)setupGroup2
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *friendsStatus = [YJCommonItem itemWithTitle:@"好友圈微博" type:CommonCellType_Switch];
    YJCommonItem *specialFocusStatus = [YJCommonItem itemWithTitle:@"特别关注微博" destVcClass:nil];
    specialFocusStatus.defaultText = @"智能";
    YJCommonItem *groupStatus = [YJCommonItem itemWithTitle:@"群微博" type:CommonCellType_Switch];
    YJCommonItem *statusHot = [YJCommonItem itemWithTitle:@"微博热点" type:CommonCellType_Switch];
    
    group.items = @[friendsStatus,specialFocusStatus,groupStatus,statusHot];
    group.header = @"新消息推送通知";
}

- (void)setupGroup3
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *nonDisturb = [YJCommonItem itemWithTitle:@"免打扰设置" destVcClass:nil];
    YJCommonItem *getNewMessage = [YJCommonItem itemWithTitle:@"获取新消息" destVcClass:nil];
    getNewMessage.defaultText = @"每半分钟";
    group.items = @[nonDisturb,getNewMessage];
}



@end

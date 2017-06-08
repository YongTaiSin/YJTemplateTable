//
//  YJReadModeViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/5.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "ReadModeViewController.h"

@implementation ReadModeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];

}

- (void)setupGroup0
{
    YJCommonGroup *group = [YJCommonGroup group];
    [self.groups addObject:group];
    
    YJCommonItem *pic = [YJCommonItem itemWithTitle:@"有图模式" type:CommonCellType_Check];
    YJCommonItem *nopic = [YJCommonItem itemWithTitle:@"无图模式" type:CommonCellType_Check];
    group.items = @[pic,nopic];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}

- (void)setupGroup1
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *thumbtails = [YJCommonItem itemWithTitle:@"显示缩略微博" type:CommonCellType_Switch];
    group.items = @[thumbtails];
}

@end

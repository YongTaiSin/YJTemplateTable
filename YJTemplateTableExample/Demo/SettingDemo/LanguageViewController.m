//
//  YJLanguageViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/5.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "LanguageViewController.h"

@implementation LanguageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
}

- (void)setupGroup0
{
    // 添加组
    YJCommonGroup *group = [YJCommonGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    YJCommonItem *sys = [YJCommonItem itemWithTitle:@"跟随系统" type:CommonCellType_Check];
    YJCommonItem *simple = [YJCommonItem itemWithTitle:@"简体中文" type:CommonCellType_Check];
    YJCommonItem *complex = [YJCommonItem itemWithTitle:@"繁體中文" type:CommonCellType_Check];
    YJCommonItem *english = [YJCommonItem itemWithTitle:@"English" type:CommonCellType_Check];
    group.items = @[sys, simple, complex, english];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}
@end

//
//  YJFontsizeViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/5.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "FontsizeViewController.h"
@implementation FontsizeViewController
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
    YJCommonGroup *group = [YJCommonGroup group];
    [self.groups addObject:group];
    
    YJCommonItem *large = [YJCommonItem itemWithTitle:@"大" type:CommonCellType_Check];
    YJCommonItem *middle = [YJCommonItem itemWithTitle:@"中" type:CommonCellType_Check];
    YJCommonItem *small = [YJCommonItem itemWithTitle:@"小" type:CommonCellType_Check];
    group.items = @[large,middle,small];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}
@end

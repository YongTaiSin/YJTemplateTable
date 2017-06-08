//
//  YJIconQualityViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/5.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "IconQualityViewController.h"

@implementation IconQualityViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroupWithHeader:(NSString *)header
{
    // 添加组
    YJCommonGroup *group = [self addGroup];
    group.header = header;
    
    // 设置数据
    YJCommonItem *high = [YJCommonItem itemWithTitle:@"高清" type:CommonCellType_Check];
    high.subtitle = @"(建议在wifi或3G网络使用)";
    YJCommonItem *normal = [YJCommonItem itemWithTitle:@"普通" type:CommonCellType_Check];
    NSString *str = nil;
    if ([header isEqualToString:@"上传图片质量"]) {
        str = @"上传";
    }else
    {
        str = @"下载";
    }
    normal.subtitle = [NSString stringWithFormat:@"(%@速度快，省流量)",str];
    group.items = @[high, normal];
    
    // 设置来源
    YJCommonItem *sourceItem = [YJCommonItem item];
    sourceItem.key = group.header;
    sourceItem.defaultText = high.title;
    group.sourceItem = sourceItem;
}

- (void)setupGroup0
{
    [self setupGroupWithHeader:@"上传图片质量"];
}

- (void)setupGroup1
{
    [self setupGroupWithHeader:@"下载图片质量"];
}

@end

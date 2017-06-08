//
//  YJGeneralViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/5.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "GeneralViewController.h"
#import "ReadModeViewController.h"
#import "IconQualityViewController.h"
#import "FontsizeViewController.h"
#import "LanguageViewController.h"

@implementation GeneralViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroups];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadTable];
}


- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
}

- (void)setupGroup0
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *read = [YJCommonItem itemWithTitle:@"阅读模式" destVcClass:[ReadModeViewController class]];
    read.defaultText = @"有图模式";
    read.readyForDestVc = ^(YJCommonItem *item, ReadModeViewController *destVc)
    {
        destVc.sourceItem = item;
    };
    YJCommonItem *font = [YJCommonItem itemWithTitle:@"字体大小" destVcClass:[FontsizeViewController class]];
    font.defaultText = @"大";
    font.readyForDestVc = ^(YJCommonItem *item, FontsizeViewController *destVc)
    {
        destVc.sourceItem = item;
    };
    YJCommonItem *remark = [YJCommonItem itemWithTitle:@"显示备注" type:CommonCellType_Switch];
    group.items = @[read,font,remark];
}

- (void)setupGroup1
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *picture = [YJCommonItem itemWithTitle:@"图片质量设置" destVcClass:[IconQualityViewController class]];
    group.items = @[picture];
}

- (void)setupGroup2
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *sound = [YJCommonItem itemWithTitle:@"声音" type:CommonCellType_Switch];
    group.items = @[sound];
}

- (void)setupGroup3
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *language = [YJCommonItem itemWithTitle:@"多语言环境" destVcClass:[LanguageViewController class]];
    language.defaultText = @"跟随系统";
    language.readyForDestVc = ^(YJCommonItem *item, LanguageViewController *destVc)
    {
        destVc.sourceItem = item;
    };
    group.items = @[language];
}

- (void)setupGroup4
{
    YJCommonGroup *group = [self addGroup];
    YJCommonItem *search = [YJCommonItem itemWithTitle:@"清空搜索历史" destVcClass:nil];
    group.items = @[search];
}

@end

//
//  YJCommonTableViewController.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/6/30.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//
//  所有静态表格类型的控制器的基类

#import <UIKit/UIKit.h>
#import "YJCommonTableView.h"

@interface YJCommonTableViewController : UIViewController<YJCommonTableDatasource,YJCommonTableDelegate>
@property (nonatomic,strong) NSMutableArray *groups;
@property (nonatomic,weak  ) YJCommonTableView *tableView;
///设置表尾部视图
@property (nonatomic,strong) UIView *tableFooterView;
///设置表头
@property (nonatomic,strong) UIView *tableHeaderView;
@property (strong, nonatomic) YJCommonItem *sourceItem;
///分割线样式
@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle; //默认有分割线
///分割线颜色
@property (nonatomic,strong) UIColor *separatorColor;
/// 添加一组
- (YJCommonGroup *)addGroup;
/// 刷新列表
- (void)reloadTable;
@end

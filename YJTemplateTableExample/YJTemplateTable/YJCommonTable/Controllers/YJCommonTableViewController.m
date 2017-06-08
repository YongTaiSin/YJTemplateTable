//
//  YJCommonTableViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/6/30.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "YJCommonTableViewController.h"

@interface YJCommonTableViewController()

@end

@implementation YJCommonTableViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setupContentView];
    self.tableView.groups = self.groups;
}

#pragma mark - 懒加载
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark - Public methods
#pragma mark 添加一组
- (YJCommonGroup *)addGroup
{
    YJCommonGroup *group = [YJCommonGroup group];
    [self.groups addObject:group];
    return group;
}
#pragma mark 刷新table
- (void)reloadTable
{
    [self.tableView reloadTable];
}
#pragma mark 设置表的footerView
- (void)setTableFooterView:(UIView *)tableFooterView
{
    _tableFooterView = tableFooterView;
    self.tableView.tableFooterView = tableFooterView;
}
#pragma mark 设置表的headerView
- (void)setTableHeaderView:(UIView *)tableHeaderView
{
    _tableHeaderView = tableHeaderView;
    self.tableView.tableHeaderView = tableHeaderView;
}
#pragma mark 设置表的分割线样式
- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
{
    _separatorStyle = separatorStyle;
    self.tableView.separatorStyle = separatorStyle;
}
#pragma mark 设置表的分割线颜色
- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    self.tableView.separatorColor = separatorColor;
}
#pragma mark - setup
- (void)setupContentView
{
    YJCommonTableView *tableView = [[YJCommonTableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

@end

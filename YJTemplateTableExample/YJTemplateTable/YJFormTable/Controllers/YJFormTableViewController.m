//
//  YJFormTableViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJFormTableViewController.h"

@interface YJFormTableViewController ()
@end

@implementation YJFormTableViewController
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
- (YJFormGroup *)addGroup
{
    YJFormGroup *group = [YJFormGroup group];
    [self.groups addObject:group];
    return group;
}
#pragma mark 刷新table
- (void)reloadTable
{
    [self.tableView reloadTable];
}
#pragma mark 收回键盘
- (void)hideKeyboard
{
    [self.tableView hideKeyboard];
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
#pragma mark 设置表单模型
- (void)setFormModel:(id)formModel
{
    _formModel = formModel;
    self.tableView.formModel = formModel;
}
#pragma mark 让某行文本框成为第一响应者
- (void)respondsToTextfieldWithIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView respondsToTextfieldWithIndexPath:indexPath];
}
#pragma mark 根据文本框对应字段让文本框成为第一响应者
- (void)respondsToTextfieldWithKey:(NSString *)key
{
    [self.tableView respondsToTextfieldWithKey:key];
}
#pragma mark - setup
- (void)setupContentView
{
    YJFormTableView *tableView = [[YJFormTableView alloc] initWithFrame:self.view.bounds];
    tableView.tf_delegate = self;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
@end

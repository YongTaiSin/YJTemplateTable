//
//  YJCommonTableView.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/31.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  所有静态表格类型的视图的基类

#import <UIKit/UIKit.h>
#import "YJCommonGroup.h"
#import "YJCommonItem.h"

@protocol YJCommonTableDelegate <NSObject>
@optional
- (CGFloat)commonTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)commonTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)commonTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (UIView *)commonTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)commonTableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (void)commonTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol YJCommonTableDatasource <NSObject>
@optional
- (NSInteger)commonTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)commonTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInCommonTableView:(UITableView *)tableView;
@end

@interface YJCommonTableView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *groups;
@property (nonatomic,strong) UITableView *tableView;
///设置表尾部视图
@property (nonatomic,strong) UIView *tableFooterView;
///设置表头
@property (nonatomic,strong) UIView *tableHeaderView;
///分割线样式
@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle; //默认有分割线
///分割线颜色
@property (nonatomic,strong) UIColor *separatorColor;
@property (strong, nonatomic) YJCommonItem *sourceItem;
@property (nonatomic, weak) id <YJCommonTableDatasource> dataSource;
@property (nonatomic, weak) id <YJCommonTableDelegate> delegate;
/// 添加一组
- (YJCommonGroup *)addGroup;
/// 刷新列表
- (void)reloadTable;
@end

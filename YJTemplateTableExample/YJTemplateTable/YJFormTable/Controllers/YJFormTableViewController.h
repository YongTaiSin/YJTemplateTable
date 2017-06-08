//
//  YJFormTableViewController.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  表单控制器

#import <UIKit/UIKit.h>
#import "YJFormTableView.h"

@interface YJFormTableViewController : UIViewController<YJFormTFDelegate,YJFormTableDelegate,YJFormTableDatasource>
@property (nonatomic,strong) NSMutableArray *groups;
@property (nonatomic,strong) id formModel;
@property(nonatomic,weak) YJFormTableView *tableView;
///设置表尾部视图
@property (nonatomic,strong) UIView *tableFooterView;
///设置表头
@property (nonatomic,strong) UIView *tableHeaderView;
///分割线样式
@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle; //默认有分割线
///分割线颜色
@property (nonatomic,strong) UIColor *separatorColor;
/// 添加一组
- (YJFormGroup *)addGroup;
/// 刷新列表
- (void)reloadTable;
/// 收回键盘
- (void)hideKeyboard;
/// 让索引为indexPath处的文本框成为第一响应者
- (void)respondsToTextfieldWithIndexPath:(NSIndexPath *)indexPath;
/// 根据某行对应的key字段让文本框成为第一响应者
- (void)respondsToTextfieldWithKey:(NSString *)key;
@end

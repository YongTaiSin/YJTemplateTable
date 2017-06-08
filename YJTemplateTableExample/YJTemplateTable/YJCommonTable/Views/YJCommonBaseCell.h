//
//  YJBgCell.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/3.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//
//  cell基类

#import <UIKit/UIKit.h>
#import "YJCommonTableStyleConfig.h"
#define kBundlePath [[NSBundle mainBundle] pathForResource:@"YJCustomTable" ofType:@"bundle"]

@interface YJCommonBaseCell : UITableViewCell
///正常背景
@property (weak, nonatomic) UIImageView *bg;
///选中背景
@property (weak, nonatomic) UIImageView *selectedBg;
///记录当前行
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (weak, nonatomic) UITableView *tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
+ (CGFloat)cellHeight;
#pragma mark - 交给子类们去实现
/** 初始化子控件 */
- (void)setup;
@end

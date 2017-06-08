//
//  FormBaseCell.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  表单cell基类

#import <UIKit/UIKit.h>
#import "YJFormTableStyleConfig.h"

@class YJFormItem;
@interface YJFormBaseCell : UITableViewCell
/** cell对应的item模型 */
@property (nonatomic,strong) YJFormItem *item;
/** 传入的表单模型 */
@property (nonatomic,strong) id formModel;
@property (strong, nonatomic) NSIndexPath *indexPath;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)cellHeight;
#pragma mark - 交给子类们去实现
/** 初始化子控件 */
- (void)setup;
/** 传入item与表单模型 */
- (void)setItem:(YJFormItem *)item formData:(id)formModel;
@end

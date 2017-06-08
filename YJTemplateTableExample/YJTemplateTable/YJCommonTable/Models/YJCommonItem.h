//
//  YJCommonItem.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/1.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//
//  存储一行的信息

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CommonCellType){
    /// 基本cell
    CommonCellType_Normal = 0,
    /// 文字居中cell
    CommonCellType_CenterButton,
    /// 单选cell
    CommonCellType_Check,
    /// 带开关cell
    CommonCellType_Switch,
    /// 自定义cell
    CommonCellType_Custom,
};

typedef void (^YJCommonItemOperation)();
typedef void (^YJCommonItemReadyForDestVc)(id item, id destVc);

@interface YJCommonItem : NSObject
///=============================================================================
/// @基础Item属性
///=============================================================================

/// 图标
@property (nonatomic,copy) NSString *icon;
/// 标题
@property (nonatomic,copy) NSString *title;
/// 标题颜色
@property (nonatomic,strong) UIColor *titleColor;
/// 标题字体
@property (nonatomic,strong) UIFont *titleFont;
/// 子标题
@property (nonatomic,copy) NSString *subtitle;
/// 右边显示的数字标记
@property (nonatomic,copy) NSString *badgevalue;
/// 封装点击这行cell想做的事情
@property (nonatomic, copy) YJCommonItemOperation operation;
/// 点击这行cell，需要调转到哪个控制器
@property (nonatomic, assign) Class destVcClass;
/// 跳转block
@property (copy, nonatomic) YJCommonItemReadyForDestVc readyForDestVc;
/// 值的key
@property (copy, nonatomic) NSString *key;
/// cell类型
@property (nonatomic, assign) CommonCellType          cellType;
/// 右边文字
@property (nonatomic,copy) NSString *text;
/// 右边文字颜色
@property (nonatomic,strong) UIColor *textColor;
/// 右边文字字体
@property (nonatomic,strong) UIFont *textFont;
/// 右边默认文字
@property (copy, nonatomic) NSString *defaultText;
@property (copy, nonatomic) NSAttributedString *defaultAttributeText;
/// 是否显示右边箭头
@property (assign, nonatomic) BOOL showAccessoryArrow;

///=============================================================================
/// @单选Item属性
///=============================================================================

@property (assign, nonatomic, getter = isChecked) BOOL checked;

///=============================================================================
/// @开关Item属性
///=============================================================================

@property (assign, nonatomic, getter = isOn) BOOL on;
@property (assign, nonatomic, getter = isDefaultOn) BOOL defaultOn;

///=============================================================================
/// @自定义cell属性
///=============================================================================

/// 指定行高
@property(nonatomic,assign) CGFloat cellHeight;
/// 自定义cell类名
@property (nonatomic, assign) Class cellClass;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title type:(CommonCellType)cellType;
+ (instancetype)itemWithTitle:(NSString *)title type:(CommonCellType)cellType;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;
- (void)didClicked:(YJCommonItemOperation)operation;
@end

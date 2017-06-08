//
//  YJCommon.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/6/15.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//
//  静态表格样式配置

///颜色宏
#define kRGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
///屏幕宽度宏
#define kTbScreenWidth   [[UIScreen mainScreen] bounds].size.width

///表格背景色
#define kTbBgColor   kRGBCOLOR(232, 232, 232)
///标题颜色
#define kCommonTableTitleColor [UIColor blackColor]
///标题字体
#define kCommonTableTitleFont [UIFont systemFontOfSize:16]
///详情文字颜色
#define kCommonTableDetailColor [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]
///详情文字字体
#define kCommonTableDetailFont [UIFont systemFontOfSize:14]
/** 表格边框的宽度 */
extern const CGFloat YJCommonTableBorderW;
/** table顶部的间距 */
extern const CGFloat YJCommonTableTopMargin;
/** 分割线左边间距 */
extern const CGFloat YJCommonTableSeperatorLeftMargin;
/** header与footer文字为空高度 */
extern const CGFloat YJCommonTableEmptySectionHeight;
/** header与footer默认最少高度 */
extern const CGFloat YJCommonTableDefaultSectionHeight;

//
//  YJCommonGroup.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/1.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//
//  存储一组的信息:组头、组尾、该组的所有行模型

#import <Foundation/Foundation.h>
@class YJCommonItem;
@interface YJCommonGroup : NSObject
///=============================================================================
/// @基础分组属性
///=============================================================================
/// 头
@property (nonatomic,copy) NSString *header;
/// 尾
@property (nonatomic,copy) NSString *footer;
///该组数据
@property (nonatomic,strong) NSArray *items;

///=============================================================================
/// @单选分组属性
///=============================================================================
/// 选中的索引
@property (assign, nonatomic) int checkedIndex;
/// 选中的item
@property (strong, nonatomic) YJCommonItem *checkedItem;
/// 来源于哪个item
@property (strong, nonatomic) YJCommonItem *sourceItem;

+ (instancetype)group;
@end

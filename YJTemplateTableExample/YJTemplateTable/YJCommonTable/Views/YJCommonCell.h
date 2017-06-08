//
//  YJCommonCell.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/1.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJCommonBaseCell.h"

@class YJCommonItem;

@interface YJCommonCell : YJCommonBaseCell
/** cell对应的item数据 */
@property (nonatomic,strong) YJCommonItem *item;
@end

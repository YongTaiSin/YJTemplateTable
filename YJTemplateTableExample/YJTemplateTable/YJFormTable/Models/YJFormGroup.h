//
//  YJFormGroup.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  表单一组信息模型:组头、组尾、该组的所有行模型

#import <Foundation/Foundation.h>

@interface YJFormGroup : NSObject
@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *footer;
@property (nonatomic,strong) NSArray *items;

+ (instancetype)group;
@end

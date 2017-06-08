//
//  YJCommonItem.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/1.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "YJCommonItem.h"

@implementation YJCommonItem
#pragma mark - init
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass
{
    YJCommonItem *item = [self itemWithIcon:icon title:title];
    item.destVcClass = destVcClass;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass
{
    return [self itemWithIcon:nil title:title destVcClass:destVcClass];
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title type:(CommonCellType)cellType
{
    YJCommonItem *item = [self itemWithIcon:icon title:title];
    item.cellType = cellType;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title type:(CommonCellType)cellType
{
    return [self itemWithIcon:nil title:title type:cellType];
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    YJCommonItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self=[super init]) {
        self.cellType = CommonCellType_Normal;
        self.showAccessoryArrow = YES;
    }
    return self;
}

#pragma mark - methods
- (void)didClicked:(YJCommonItemOperation)operation
{
    self.operation = operation;
}

#pragma mark - property
- (NSString *)key
{
    return _key ? _key : self.title;
}

- (BOOL)isOn
{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:self.key];
    if (value == nil) {
        return self.isDefaultOn;
    } else {
        return [value boolValue];
    }
}

- (void)setOn:(BOOL)on
{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:self.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)text
{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:self.key];
    if (value == nil) {
        return self.defaultText;
    } else {
        return value;
    }
}

- (void)setText:(NSString *)text
{
    [[NSUserDefaults standardUserDefaults] setObject:text forKey:self.key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

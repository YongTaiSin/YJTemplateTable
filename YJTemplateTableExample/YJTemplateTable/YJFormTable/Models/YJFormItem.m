//
//  FormItemModel.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJFormItem.h"

@implementation YJFormItem
#pragma mark - init
+ (instancetype)item
{
    return [[self alloc] init];
}

+ (instancetype)itemWithPlaceholder:(NSString *)placeHolder
{
    YJFormItem *item = [YJFormItem item];
    item.placeholder = placeHolder;
    return item;
}

+ (instancetype)itemWithPlaceholder:(NSString *)placeHolder key:(NSString *)key
{
    YJFormItem *item = [YJFormItem itemWithPlaceholder:placeHolder];
    item.key = key;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeHolder
{
    YJFormItem *item = [YJFormItem itemWithPlaceholder:placeHolder];
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeHolder key:(NSString *)key
{
    YJFormItem *item = [YJFormItem itemWithTitle:title placeholder:placeHolder];
    item.key = key;
    return item;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.cellType = FormCellType_TF;
        self.returnKeyType = UIReturnKeyNext;
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}
- (void)didClicked:(YJFormItemOperation)operation
{
    self.operation = operation;
}
- (void)shouldChangeCharacters:(YJFormShouldInputTextBlock)inputTextBlock
{
    self.inputTextBlock = inputTextBlock;
}
@end

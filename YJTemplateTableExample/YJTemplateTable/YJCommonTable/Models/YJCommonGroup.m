//
//  YJCommonGroup.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/1.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "YJCommonGroup.h"
#import "YJCommonItem.h"

@implementation YJCommonGroup

+ (instancetype)group
{
    return [[self alloc]init];
}

- (YJCommonItem *)checkedItem
{
    for (YJCommonItem *item in self.items) {
        if (item.isChecked) return item;
    }
    return nil;
}

- (void)setCheckedItem:(YJCommonItem *)checkedItem
{
    for (YJCommonItem *item in self.items) {
        item.checked = (item == checkedItem);
    }
    self.sourceItem.text = checkedItem.title;
}

- (int)checkedIndex
{
    for (int i = 0; i<self.items.count; i++) {
        YJCommonItem *item = self.items[i];
        if (item.isChecked) return i;
    }
    return -1;
}

- (void)setCheckedIndex:(int)checkedIndex
{
    if (checkedIndex <0 || checkedIndex >= self.items.count) return;
    
    self.checkedItem = self.items[checkedIndex];
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    self.sourceItem = self.sourceItem;
}

- (void)setSourceItem:(YJCommonItem *)sourceItem
{
    _sourceItem = sourceItem;
    
    for (YJCommonItem *item in self.items) {
        item.checked = [item.title isEqualToString:sourceItem.text];
    }
}
@end

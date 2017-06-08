
//
//  YJCenterButtonCell.m
//  WechatDemo
//
//  Created by Jeremiah on 2017/6/6.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJCenterButtonCell.h"
#import "YJCommonItem.h"

@implementation YJCenterButtonCell

#pragma mark - 覆盖父类的方法
- (void)setup
{
    [super setup];

    // 标题
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = kCommonTableTitleColor;
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
    self.textLabel.font = kCommonTableTitleFont;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - setter
- (void)setItem:(YJCommonItem *)item
{
    _item = item;
    self.textLabel.text = self.item.title;
    self.textLabel.textColor = self.item.titleColor?self.item.titleColor:kCommonTableTitleColor;
    self.textLabel.font = self.item.titleFont?self.item.titleFont:kCommonTableTitleFont;
}

@end

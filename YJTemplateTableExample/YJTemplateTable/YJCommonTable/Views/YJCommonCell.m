//
//  YJCommonCell.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/1.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "YJCommonCell.h"
#import "YJCommonItem.h"
#import "YJBadgeButton.h"
#import "UIView+Frame.h"

@interface YJCommonCell()
/**
 *  子标题
 */
@property (nonatomic,strong) UILabel *subtitleLabel;

/**
 *  箭头
 */
@property (nonatomic,strong) UIImageView *arrowView;
/**
 *  打钩
 */
@property (strong, nonatomic) UIImageView *checkView;
/**
 *  提醒数字
 */
@property (nonatomic,strong) YJBadgeButton *badgeView;
/**
 *  开关
 */
@property (nonatomic,strong) UISwitch *switchView;
@end

@implementation YJCommonCell
#pragma mark - 懒加载
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[kBundlePath stringByAppendingPathComponent:@"common_icon_arrow"]]];
    }
    return _arrowView;
}

- (YJBadgeButton *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[YJBadgeButton alloc]init];
    }
    return _badgeView;
}

- (UIImageView *)checkView
{
    if (!_checkView) {
        _checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[kBundlePath stringByAppendingPathComponent:@"common_icon_checkmark"]]];
    }
    return _checkView;
}

- (UISwitch *)switchView
{
    if (!_switchView) {
        _switchView = [[UISwitch alloc]init];
        [_switchView addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)switchChange
{
    // 存储数据
    YJCommonItem *switchItem = self.item;
    switchItem.on = self.switchView.isOn;
}

#pragma mark - 覆盖父类的方法
- (void)setup
{
    [super setup];
    // 子标题
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.textColor = [UIColor lightGrayColor];
    subtitleLabel.highlightedTextColor = subtitleLabel.textColor;
    subtitleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:subtitleLabel];
    self.subtitleLabel = subtitleLabel;
    
    
    // 标题
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = kCommonTableTitleColor;
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
    self.textLabel.font = kCommonTableTitleFont;
    
    // 最右边的详情文字
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.textColor = kCommonTableDetailColor;
    self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor;
    self.detailTextLabel.font = kCommonTableDetailFont;
    
//    // 去除cell的默认背景色
//    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - setter
- (void)setItem:(YJCommonItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的控件
    [self setupRightView];

    // 3.设置样式
    [self setupCellStyle];
}

/**
 *  设置数据
 */
- (void)setupData
{
    // 1.图标
    if (self.item.icon) {
         self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    // 2.标题
    self.textLabel.text = self.item.title;
    
    // 3.子标题
    if (self.item.subtitle) {
        self.subtitleLabel.hidden = NO;
        self.subtitleLabel.text = self.item.subtitle;
    } else {
        self.subtitleLabel.hidden = YES;
    }
    // 右边文字
    if (self.item.cellType == CommonCellType_Normal) {
        self.detailTextLabel.text = self.item.text;
    }
}

/**
 *  设置样式
 */
- (void)setupCellStyle
{
    // 1.标题
    self.textLabel.textColor = self.item.titleColor?self.item.titleColor:kCommonTableTitleColor;
    self.textLabel.highlightedTextColor = self.textLabel.textColor;
    self.textLabel.font = self.item.titleFont?self.item.titleFont:kCommonTableTitleFont;
    
    // 2.右边文字
    self.detailTextLabel.textColor = self.item.textColor?self.item.textColor:kCommonTableDetailColor;
    self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor;
    self.detailTextLabel.font = self.item.textFont?self.item.textFont:kCommonTableDetailFont;
}


/**
 *  设置右边的控件
 */
- (void)setupRightView
{
    self.accessoryView = nil;
    switch (self.item.cellType) {
        case CommonCellType_Normal:
        {
            if (self.item.badgevalue)
            { // 右边显示数字
                self.badgeView.badgeValue = self.item.badgevalue;
                if (self.item.showAccessoryArrow) {
                    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, [YJCommonCell cellHeight])];
                    [rightView addSubview:self.badgeView];
                    [rightView addSubview:self.arrowView];
                    self.arrowView.yj_x = CGRectGetMaxX(self.badgeView.frame);
                    self.badgeView.yj_centerY = self.arrowView.yj_centerY = rightView.yj_centerY;
                    rightView.yj_width = CGRectGetMaxX(self.arrowView.frame);
                    self.accessoryView = rightView;
                }else
                {
                    self.accessoryView = self.badgeView;
                }
            }else
            {
                if (self.item.showAccessoryArrow) {
                    self.accessoryView = self.arrowView;
                }
            }
        }
            break;
        case CommonCellType_Switch: // 右边是开关
        {
            self.switchView.on = self.item.isOn;
            self.accessoryView = self.switchView;
        }
            break;
        case CommonCellType_Check:  // 右边是打钩
        {
            self.accessoryView = self.item.isChecked ? self.checkView : nil;
        }
            break;
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.item.subtitle == nil) return;
    // 设置子标题
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.subtitleLabel.font;
    CGSize subtitleSize = [self.item.subtitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    CGFloat subtitleW = subtitleSize.width;
    CGFloat subtitleH = subtitleSize.height;
    CGFloat subtitleX = CGRectGetMaxX(self.textLabel.frame) + 5;
    CGFloat subtitleY = (self.contentView.frame.size.height - subtitleH) * 0.5+1;
    self.subtitleLabel.frame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleH);
}

@end

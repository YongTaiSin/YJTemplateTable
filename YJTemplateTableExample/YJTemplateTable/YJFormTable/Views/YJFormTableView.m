//
//  YJFormTableView.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJFormTableView.h"
#import "YJFormTFCell.h"
#import "YJFormCustomCell.h"

@interface YJFormTableView()<YJFormTFDelegate>

@end
@implementation YJFormTableView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - 懒加载
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark - Public methods
#pragma mark 添加一组
- (YJFormGroup *)addGroup
{
    YJFormGroup *group = [YJFormGroup group];
    [self.groups addObject:group];
    return group;
}
#pragma mark 刷新table
- (void)reloadTable
{
    [self.tableView reloadData];
}
#pragma mark 收回键盘
- (void)hideKeyboard
{
    [self endEditing:YES];
}
#pragma mark 设置表的footerView
- (void)setTableFooterView:(UIView *)tableFooterView
{
    _tableFooterView = tableFooterView;
    self.tableView.tableFooterView = tableFooterView;
}
#pragma mark 设置表的headerView
- (void)setTableHeaderView:(UIView *)tableHeaderView
{
    _tableHeaderView = tableHeaderView;
    self.tableView.tableHeaderView = tableHeaderView;
}
#pragma mark 设置表的分割线样式
- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
{
    _separatorStyle = separatorStyle;
    self.tableView.separatorStyle = separatorStyle;
}
#pragma mark 设置表的分割线颜色
- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    self.tableView.separatorColor = separatorColor;
}
#pragma mark 让某行文本框成为第一响应者
- (void)respondsToTextfieldWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[YJFormTFCell class]]) {
        [((YJFormTFCell *)cell).tf becomeFirstResponder];
    }
}
#pragma mark 根据文本框对应字段让文本框成为第一响应者
- (void)respondsToTextfieldWithKey:(NSString *)key
{
    __block NSIndexPath *indexPath = nil;
    [self.groups enumerateObjectsUsingBlock:^(YJFormGroup  *_Nonnull group, NSUInteger section, BOOL * _Nonnull stop) {
        [group.items enumerateObjectsUsingBlock:^(YJFormItem  *_Nonnull item, NSUInteger row, BOOL * _Nonnull stop) {
            if ([item.key isEqualToString:key]) {
                indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                *stop = YES;
            }
        }];
    }];
    if (indexPath) {
        [self respondsToTextfieldWithIndexPath:indexPath];
    }
}

#pragma mark - 计算文字尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
}

#pragma mark - setup
- (void)setup
{
    // 设置tableView属性
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorColor = [UIColor colorWithRed:(228)/255.0 green:(228)/255.0 blue:(228)/255.0 alpha:1.0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)]];
    [self addSubview:self.tableView];
    self.backgroundColor = kFormTbBgColor;
    
    // 底部控件
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, 0, 1);
    self.tableView.tableFooterView = footer;

}

#pragma mark - YJFormTFDelegate
- (BOOL)yj_formTF:(UITextField *)tf shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string indexPath:(NSIndexPath *)indexPath item:(YJFormItem *)item
{
    if ([self.tf_delegate respondsToSelector:@selector(yj_formTF:shouldChangeCharactersInRange:replacementString:indexPath:item:)]) {
        return [self.tf_delegate yj_formTF:tf shouldChangeCharactersInRange:range replacementString:string indexPath:indexPath item:item];
    }
    return YES;
}
- (BOOL)yj_formTF:(UITextField *)tf shouldReturnForIndexPath:(NSIndexPath *)indexPath item:(YJFormItem *)item
{
    if ([self.tf_delegate respondsToSelector:@selector(yj_formTF:shouldReturnForIndexPath:item:)]) {
        return [self.tf_delegate yj_formTF:tf shouldReturnForIndexPath:indexPath item:item];
    }
    return YES;
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInFormTableView:)]) {
        return [self.dataSource numberOfSectionsInFormTableView:tableView];
    }
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(formTableView:numberOfRowsInSection:)]) {
        return [self.dataSource formTableView:tableView numberOfRowsInSection:section];
    }
    YJFormGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(formTableView:cellForRowAtIndexPath:)]) {
        [self.dataSource formTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    YJFormGroup *group = self.groups[indexPath.section];
    YJFormItem *item = group.items[indexPath.row];
    switch (item.cellType) {
        case FormCellType_TF:
        case FormCellType_ActionTF:
        {
            YJFormTFCell *cell = [YJFormTFCell cellWithTableView:tableView];
            cell.indexPath = indexPath;
            cell.delegate = self;
            [cell setItem:item formData:self.formModel];
            return cell;
        }
            break;
        case FormCellType_Custom:
        {
            YJFormCustomCell *cell = [[item.cellClass class] cellWithTableView:tableView];
            return cell;
        }
        default:
            break;
    }
    static NSString *cellID = @"defaultCellID";
    UITableViewCell *defaultCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!defaultCell) {
        defaultCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return defaultCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YJFormGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    YJFormGroup *group = self.groups[section];
    return group.footer;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, YJFormTableSeperatorLeftMargin, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, YJFormTableSeperatorLeftMargin, 0, 0)];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(formTableView:heightForRowAtIndexPath:)]) {
        return [self.delegate formTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    // 1.取出这行对应的item模型
    YJFormGroup *group = self.groups[indexPath.section];
    YJFormItem *item = group.items[indexPath.row];
    if (item.cellHeight) {
        return item.cellHeight;
    }
    return [YJFormTFCell cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(formTableView:heightForHeaderInSection:)]) {
        return [self.delegate formTableView:tableView heightForHeaderInSection:section];
    }
    YJFormGroup *group = self.groups[section];
    if (group.header) {
        CGFloat height = [self sizeWithText:group.header font:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(CGRectGetWidth(self.frame)-15.0*2, MAXFLOAT)].height;
        return height>YJFormTableDefaultSectionHeight?height+15:YJFormTableDefaultSectionHeight;
    }
    return section==0?YJFormTableTopMargin:YJFormTableEmptySectionHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(formTableView:heightForFooterInSection:)]){
        return [self.delegate formTableView:tableView heightForFooterInSection:section];
    }
    YJFormGroup *group = self.groups[section];
    if (group.footer) {
        CGFloat height = [self sizeWithText:group.footer font:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(CGRectGetWidth(self.frame)-15.0*2, MAXFLOAT)].height;
        return height>YJFormTableDefaultSectionHeight?height+15:YJFormTableDefaultSectionHeight;
    }

    return YJFormTableEmptySectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(formTableView:viewForHeaderInSection:)]) {
        return [self.delegate formTableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(formTableView:viewForFooterInSection:)]) {
        return [self.delegate formTableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}

@end


//
//  YJCommonTableView.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/31.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJCommonTableView.h"
#import "YJCommonCell.h"
#import "YJCommonCustomCell.h"
#import "YJCenterButtonCell.h"


@implementation YJCommonTableView

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
- (YJCommonGroup *)addGroup
{
    YJCommonGroup *group = [YJCommonGroup group];
    [self.groups addObject:group];
    return group;
}
#pragma mark 刷新table
- (void)reloadTable
{
    [self.tableView reloadData];
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
#pragma mark 當前棧頂控制器
- (UIViewController*)yj_currentViewController; {
    UIViewController *topViewController = [[[UIApplication sharedApplication].delegate window] rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = kRGBCOLOR(217, 216, 217);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;
    [self addSubview:self.tableView];
    self.backgroundColor = kTbBgColor;
    
    // 底部控件
    UIView *footer = [[UIView alloc] init];
    footer.frame = CGRectMake(0, 0, 0, 1);
    self.tableView.tableFooterView = footer;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInCommonTableView:)]) {
        return [self.dataSource numberOfSectionsInCommonTableView:tableView];
    }
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(commonTableView:numberOfRowsInSection:)]) {
        return [self.dataSource commonTableView:tableView numberOfRowsInSection:section];
    }
    YJCommonGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(commonTableView:cellForRowAtIndexPath:)]) {
        [self.dataSource commonTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    YJCommonGroup *group = self.groups[indexPath.section];
    YJCommonItem *item = group.items[indexPath.row];
    if (item.cellType==CommonCellType_Custom) {
        YJCommonCustomCell *cell = [[item.cellClass class] cellWithTableView:tableView];
        cell.indexPath = indexPath;
        return cell;
    }
    if (item.cellType==CommonCellType_CenterButton) {
        YJCenterButtonCell *cell = [YJCenterButtonCell cellWithTableView:tableView style:UITableViewCellStyleDefault];
        cell.item = item;
        return cell;
    }
    YJCommonCell *cell = [YJCommonCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.item = item;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YJCommonGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    YJCommonGroup *group = self.groups[section];
    return group.footer;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, YJCommonTableSeperatorLeftMargin, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, YJCommonTableSeperatorLeftMargin, 0, 0)];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(commonTableView:heightForRowAtIndexPath:)]) {
        return [self.delegate commonTableView:tableView heightForRowAtIndexPath:indexPath];
    }
    // 1.取出这行对应的item模型
    YJCommonGroup *group = self.groups[indexPath.section];
    YJCommonItem *item = group.items[indexPath.row];
    if (item.cellHeight) {
        return item.cellHeight;
    }
    return [YJCommonCell cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(commonTableView:heightForHeaderInSection:)]) {
        return [self.delegate commonTableView:tableView heightForHeaderInSection:section];
    }
    YJCommonGroup *group = self.groups[section];
    if (group.header) {
        CGFloat height = [self sizeWithText:group.header font:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(CGRectGetWidth(self.frame)-15.0*2, MAXFLOAT)].height;
        return height>YJCommonTableDefaultSectionHeight?height+15:YJCommonTableDefaultSectionHeight;
    }
    return section==0?YJCommonTableTopMargin:YJCommonTableEmptySectionHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(commonTableView:heightForFooterInSection:)]){
        return [self.delegate commonTableView:tableView heightForFooterInSection:section];
    }
    YJCommonGroup *group = self.groups[section];
    if (group.footer) {
        CGFloat height = [self sizeWithText:group.footer font:[UIFont systemFontOfSize:13.0] maxSize:CGSizeMake(CGRectGetWidth(self.frame)-15.0*2, MAXFLOAT)].height;
        return height>YJCommonTableDefaultSectionHeight?height+15:YJCommonTableDefaultSectionHeight;
    }
    return YJCommonTableEmptySectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(commonTableView:viewForHeaderInSection:)]) {
        return [self.delegate commonTableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(commonTableView:viewForFooterInSection:)]) {
        return [self.delegate commonTableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(commonTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate commonTableView:tableView didSelectRowAtIndexPath:indexPath];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1.取出这行对应的item模型
    YJCommonGroup *group = self.groups[indexPath.section];
    YJCommonItem *item = group.items[indexPath.row];
    
    // 2.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
    // 3.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        
        if (item.readyForDestVc) { // 控制器的准备工作
            item.readyForDestVc(item, destVc);
        }
        
        [self.yj_currentViewController.navigationController pushViewController:destVc animated:YES];
    }
    
    // 4.check 打钩
    if (item.cellType==CommonCellType_Check) {
        group.checkedIndex = (int)indexPath.row;
        
        // 刷新
        [tableView reloadData];
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

@end

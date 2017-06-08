//
//  YJBgCell.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/7/3.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "YJCommonBaseCell.h"

@implementation YJCommonBaseCell
#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    return [self cellWithTableView:tableView style:UITableViewCellStyleValue1];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style
{
    static NSString *cellID;
    cellID = NSStringFromClass([self class]);
    YJCommonBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        NSString *path = [[NSBundle mainBundle]pathForResource:NSStringFromClass([self class]) ofType:@"nib"];
        if (path) {
            id nib = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
            cell = nib;
            [cell setValue:cellID forKey:@"reuseIdentifier"];
        }else
        {
            cell = [[[self class] alloc]initWithStyle:style reuseIdentifier:cellID];
        }
        cell.tableView = tableView;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIImageView *bg = [[UIImageView alloc] init];
//        self.backgroundView = bg;
//        self.bg = bg;
//        
//        UIImageView *selectedBg = [[UIImageView alloc] init];
//        self.selectedBackgroundView = selectedBg;
//        self.selectedBg = selectedBg;
        
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
//    NSInteger totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
//    NSString *bgName = nil;
//    NSString *selectedBgName = nil;
//    if (totalRows == 1) { // 这组就1行
//        bgName = @"common_card_background";
//        selectedBgName = @"common_card_background_highlighted";
//    } else if (indexPath.row == 0) { // 首行
//        bgName = @"common_card_top_background";
//        selectedBgName = @"common_card_top_background_highlighted";
//    } else if (indexPath.row == totalRows - 1) { // 尾行
//        bgName = @"common_card_bottom_background";
//        selectedBgName = @"common_card_bottom_background_highlighted";
//    } else { // 中行
//        bgName = @"common_card_middle_background";
//        selectedBgName = @"common_card_middle_background_highlighted";
//    }
//    self.bg.image = [self resizableImage:[kBundlePath stringByAppendingPathComponent:bgName]];
//    self.selectedBg.image = [self resizableImage:[kBundlePath stringByAppendingPathComponent:selectedBgName]];
}

#pragma mark - methods
- (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat edgeW = normal.size.width * 0.5;
    CGFloat edgeH = normal.size.height * 0.5;
    return [normal stretchableImageWithLeftCapWidth:edgeW topCapHeight:edgeH];
}

+ (CGFloat)cellHeight
{
    return 45.0f;
}

-(void)setup
{
    //界面交给子类去实现
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = YJCommonTableBorderW;
    frame.size.width -= 2 * YJCommonTableBorderW;
    [super setFrame:frame];
}
@end

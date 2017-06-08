//
//  FormBaseCell.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJFormBaseCell.h"
#import "YJFormItem.h"

@interface YJFormBaseCell()
@end
@implementation YJFormBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID;
    cellID = NSStringFromClass([self class]);
    YJFormBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        NSString *path = [[NSBundle mainBundle]pathForResource:NSStringFromClass([self class]) ofType:@"nib"];
        if (path) {
            id nib = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
            cell = nib;
            [cell setValue:cellID forKey:@"reuseIdentifier"];
        }else
        {
            cell = [[[self class] alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

+ (CGFloat)cellHeight
{
    return 45.0f;
}

-(void)setup
{
    //界面交给子类去实现
}
- (void)setItem:(YJFormItem *)item formData:(id)formModel
{
    _item = item;
    _formModel = formModel;
    //模型赋值交给子类去实现
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = YJFormTableBorderW;
    frame.size.width -= 2 * YJFormTableBorderW;
    [super setFrame:frame];
}
@end

//
//  FormTFCell.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "YJFormTFCell.h"
#import "YJFormItem.h"

@interface YJFormTFCell()<UITextFieldDelegate>
/// 無標題時左视图
@property (nonatomic,strong) UIView *defaultLeftView;
/// 左视图
@property (nonatomic,strong) UIView *leftView;
/// titleLb
@property (nonatomic,weak  ) UILabel *titleLb;
/// 右视图
@property (nonatomic,strong) UIImageView *arrowView;
/// 点击按钮
@property (nonatomic,weak  ) UIButton *touchBtn;
@end
@implementation YJFormTFCell
#pragma mark - 懒加载
- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [[UIView alloc]init];
        UILabel *titleLb = [[UILabel alloc]init];
        [_leftView addSubview:titleLb];
        self.titleLb = titleLb;
    }
    return _leftView;
}
- (UIView *)defaultLeftView
{
    if (!_defaultLeftView) {
        _defaultLeftView = [[UIView alloc]init];
    }
    return _defaultLeftView;
}
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

#pragma mark - handle
- (void)cellClicked:(UIButton *)button
{
    if (self.item.operation) {
        self.item.operation(self.item);
    }
}
#pragma mark - 覆盖父类的方法
- (void)setup
{
    [super setup];
    //textField
    UITextField *tf = [[UITextField alloc]init];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.rightViewMode = UITextFieldViewModeAlways;
    tf.backgroundColor = [UIColor whiteColor];
    tf.delegate = self;
    [self.contentView addSubview:tf];
    self.tf = tf;
    //touchBtn
    UIButton *touchBtn = [[UIButton alloc]init];
    [touchBtn addTarget:self action:@selector(cellClicked:) forControlEvents:UIControlEventTouchUpInside];
    touchBtn.hidden = YES;
    [self.contentView addSubview:touchBtn];
    self.touchBtn = touchBtn;
}
- (void)resetData
{
    self.tf.text = @"";
    self.tf.placeholder = @"";
    self.tf.leftView = nil;
    self.leftView = nil;
    self.tf.enabled = YES;
    self.tf.rightView = nil;
    self.arrowView = nil;
    self.touchBtn.hidden = YES;
}
- (void)setItem:(YJFormItem *)item formData:(id)formModel
{
    [super setItem:item formData:formModel];
    [self resetData];
    if (item.title) {
        self.tf.leftView = self.leftView;
        self.titleLb.text = item.title;
    }else
    {
        self.tf.leftView = self.defaultLeftView;
    }
    self.tf.secureTextEntry = item.secureTextEntry;
    self.tf.keyboardType = item.keyboardType;
    self.tf.returnKeyType = item.returnKeyType;
    self.tf.placeholder = item.placeholder;
    self.tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf.text = [formModel valueForKey:item.key];
    if (item.cellType == FormCellType_ActionTF) {
        self.tf.enabled = NO;
        self.tf.rightView = self.arrowView;
        self.touchBtn.hidden = NO;
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.formModel setValue:[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:self.item.key]; // 将textField中的值赋给_formModel
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if ([self.delegate respondsToSelector:@selector(yj_formTF:shouldChangeCharactersInRange:replacementString:indexPath:item:)]) {
        return [self.delegate yj_formTF:textField shouldChangeCharactersInRange:range replacementString:string indexPath:self.indexPath item:self.item];
    }
    if (self.item.inputTextBlock) {
        return self.item.inputTextBlock(textField,range,string);
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(yj_formTF:shouldReturnForIndexPath:item:)]) {
        return [self.delegate yj_formTF:textField shouldReturnForIndexPath:self.indexPath item:self.item];
    }
    return YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _tf.frame = self.contentView.bounds;
    _leftView.frame = CGRectMake(0, 0, 130, self.contentView.bounds.size.height);
    _defaultLeftView.frame = CGRectMake(0, 0, 15, self.contentView.bounds.size.height);
    _titleLb.frame = CGRectMake(15, 0, 130-15*2, self.contentView.bounds.size.height);
    _touchBtn.frame = self.contentView.bounds;
}
@end

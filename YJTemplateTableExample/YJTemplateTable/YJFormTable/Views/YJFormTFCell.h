//
//  FormTFCell.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  文本输入框表单cell

#import "YJFormBaseCell.h"
#import "YJFormTFDelegate.h"

@interface YJFormTFCell : YJFormBaseCell
@property (nonatomic, weak) id<YJFormTFDelegate> delegate;
/// 文本框
@property(nonatomic,weak   ) UITextField *tf;
@end

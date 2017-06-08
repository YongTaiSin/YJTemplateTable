//
//  FormItemModel.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/16.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  表单item模型

#import <UIKit/UIKit.h>
@class YJFormItem;
typedef NS_ENUM(NSUInteger,FormCellType){
    ///文本框
    FormCellType_TF = 0,
    ///textView
    FormCellType_TV,
    ///不可编辑文本框
    FormCellType_ActionTF,
    ///自定义cell
    FormCellType_Custom,
};
typedef void (^YJFormItemOperation)(YJFormItem *item);
typedef BOOL (^YJFormShouldInputTextBlock)(UITextField *textField,NSRange range,NSString *string);
@interface YJFormItem : NSObject
///=============================================================================
/// @基础表单属性
///=============================================================================
/// title
@property (nonatomic, copy) NSString                    *title;
/// 占位文字
@property (nonatomic, copy) NSString                    *placeholder;
/// 表单对应的字段
@property (nonatomic, copy) NSString                    *key;
/// 校验出错时的提示信息
@property (nonatomic, copy) NSString                    *errText;
/// 是否必填
@property (nonatomic, assign ,getter=isRequired)        BOOL   required;
/// 是否显示*
@property(nonatomic,getter=isSecureTextEntry)           BOOL secureTextEntry;       // default is NO
/// 键盘类型
@property(nonatomic) UIKeyboardType keyboardType;       // default is UIKeyboardTypeDefault
/// return键类型
@property(nonatomic) UIReturnKeyType returnKeyType;                       // default is UIReturnKeyDefault
/// cell的类型
@property (nonatomic, assign) FormCellType              cellType;
/// 最大输入长度限制
@property (nonatomic, assign) NSInteger                 maxInputLength;
/// 点击cell事件
@property (nonatomic, copy) YJFormItemOperation         operation;
/// 拦截文本输入
@property (nonatomic, copy) YJFormShouldInputTextBlock  inputTextBlock;
/// 点击这行cell，需要调转到哪个控制器
@property (nonatomic, assign) Class destVcClass;
///=============================================================================
/// @自定义cell属性
///=============================================================================
/// 指定行高
@property(nonatomic,assign) CGFloat cellHeight;
/// 自定义cell类名
@property (nonatomic, assign) Class cellClass;

+ (instancetype)item;
+ (instancetype)itemWithPlaceholder:(NSString *)placeHolder;
+ (instancetype)itemWithPlaceholder:(NSString *)placeHolder key:(NSString *)key;
+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeHolder;
+ (instancetype)itemWithTitle:(NSString *)title placeholder:(NSString *)placeHolder key:(NSString *)key;
- (void)didClicked:(YJFormItemOperation)operation;
- (void)shouldChangeCharacters:(YJFormShouldInputTextBlock)inputTextBlock;
@end

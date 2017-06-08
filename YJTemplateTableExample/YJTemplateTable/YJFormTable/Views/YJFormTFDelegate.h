//
//  YJFormTFDelegate.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/23.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YJFormTFDelegate <NSObject>
@optional
/** 拦截文本输入 */
- (BOOL)yj_formTF:(UITextField *)tf shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string indexPath:(NSIndexPath *)indexPath item:(YJFormItem *)item;
/** 拦截return键事件 */
- (BOOL)yj_formTF:(UITextField *)tf shouldReturnForIndexPath:(NSIndexPath *)indexPath item:(YJFormItem *)item;
@end

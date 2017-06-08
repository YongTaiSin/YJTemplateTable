//
//  RegisterFormModel.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/5/22.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//
//  注册请求参数模型

#import <Foundation/Foundation.h>

@interface RegisterFormModel : NSObject

///账号
@property(nonatomic,copy) NSString *azID;
///密码
@property(nonatomic,copy) NSString *password;
///确认密码
@property(nonatomic,copy) NSString *confirmPassword;
///生日
@property(nonatomic,copy) NSString *birthday;
///手机号
@property(nonatomic,copy) NSString *mobile;
///用户昵称
@property(nonatomic,copy) NSString *nickName;
///邮箱
@property(nonatomic,copy) NSString *email;
@end

//
//  RegisterViewController.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 2017/6/1.
//  Copyright © 2017年 Jeremiah. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterFormModel.h"
#define kScreenHeight                   [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth                    [[UIScreen mainScreen] bounds].size.width
#define UIColorFromHex(hexValue)        [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"註冊";
    [self configureData];
    [self setupGroups];
    [self setupView];

}

#pragma mark - setup
- (void)configureData
{
    RegisterFormModel *registerFormModel = [[RegisterFormModel alloc]init];
    registerFormModel.birthday = @"1900-01-01";
    self.formModel = registerFormModel;
}

- (void)setupView
{
    NSString *tipsStr = @"溫馨提示:\n1、一個手機號碼只能註冊一次；\n2、填寫容易記住的帳號以防忘記；\n3、密碼與昵稱均可以在註冊登錄後更改；\n4、忘記密碼可以選擇使用手機號找回密碼。";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    CGFloat tipHeight = [tipsStr boundingRectWithSize:CGSizeMake(kScreenWidth-2*15, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size.height;
    CGFloat btnHeight = 40;
    CGFloat margin = 40;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, margin+btnHeight+margin+tipHeight+20)];
    //註冊
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(15, margin, footerView.bounds.size.width-2*15, btnHeight)];
    [registerButton setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:(12)/255.0 green:(15)/255.0 blue:(50)/255.0 alpha:1.0]] forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
    registerButton.layer.cornerRadius = 4;
    registerButton.layer.masksToBounds = YES;
    [registerButton setTitle:@"確定註冊" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerConfirmClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:registerButton];
    
    //tips
    UILabel *tipsLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(registerButton.frame)+margin, kScreenWidth-2*15, tipHeight)];
    tipsLb.font = [UIFont systemFontOfSize:14];
    tipsLb.textColor = UIColorFromHex(0x9e9e9e);
    tipsLb.numberOfLines = 0;
    tipsLb.text = tipsStr;
    [footerView addSubview:tipsLb];
    self.tableView.tableFooterView = footerView;
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    YJFormGroup *group = [self addGroup];
    group.footer = @"賬號由字母數字組成首字符必須是英文字母";
    YJFormItem *accountItem = [YJFormItem itemWithTitle:@"賬號" placeholder:@"请輸入賬號(必填)" key:@"azID"];
    accountItem.keyboardType = UIKeyboardTypeASCIICapable;
    group.items = @[accountItem];
}

- (void)setupGroup1
{
    YJFormGroup *group = [self addGroup];
    YJFormItem *pwdItem = [YJFormItem itemWithTitle:@"密碼" placeholder:@"请輸入密碼(必填)" key:@"password"];
    pwdItem.secureTextEntry = YES;
    
    YJFormItem *confirmPwdItem = [YJFormItem itemWithTitle:@"確認密碼" placeholder:@"请輸入確認密碼(必填)" key:@"confirmPassword"];
    confirmPwdItem.secureTextEntry = YES;
    
    YJFormItem *areaItem = [YJFormItem itemWithTitle:@"出生日期" placeholder:@"请輸入生日(必填)" key:@"birthday"];
    areaItem.cellType = FormCellType_ActionTF;
    typeof(self) __weak weakSelf = self;
    [areaItem didClicked:^(YJFormItem *item){
        [weakSelf hideKeyboard];
        [weakSelf showDatePicker];
    }];
    
    
    YJFormItem *phoneItem = [YJFormItem itemWithTitle:@"手機號碼" placeholder:@"请輸入手機號碼(必填)" key:@"mobile"];
    phoneItem.keyboardType = UIKeyboardTypeNumberPad;
    
    YJFormItem *nickNameItem = [YJFormItem itemWithTitle:@"用戶暱稱" placeholder:@"请輸入暱稱(選填)" key:@"nickName"];
    
    YJFormItem *emailItem = [YJFormItem itemWithTitle:@"保密郵箱" placeholder:@"请輸入郵箱(選填)" key:@"email"];
    emailItem.keyboardType = UIKeyboardTypeASCIICapable;
    
    group.items = @[pwdItem,confirmPwdItem,areaItem,phoneItem,nickNameItem,emailItem];
}

#pragma mark - handle
- (void)registerConfirmClicked:(UIButton *)button
{
    [self hideKeyboard];
    [self checkUserInputIsOk];
}

#pragma mark - methods
// 生成一张指定颜色的图片
- (UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)showDatePicker
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *maskView = [window viewWithTag:999];
    if (!maskView) {
        UIView *maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        maskView.tag = 999;
        maskView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker)]];
        [[UIApplication sharedApplication].keyWindow addSubview:maskView];
        UIDatePicker *datePicker = [[UIDatePicker alloc]init];
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.frame = CGRectMake(0, kScreenHeight-200, kScreenWidth, 200);
        //设置背景颜色
        datePicker.backgroundColor = [UIColor blueColor];
        //设置本地化支持的语言（在此是中文)
        datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //显示方式是只显示年月日
        datePicker.datePickerMode = UIDatePickerModeDate;
        //放在盖板上
        [maskView addSubview:datePicker];
    }
    maskView.hidden = NO;
}
- (void)dismissDatePicker
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *maskView = [window viewWithTag:999];
    maskView.hidden = YES;
}
- (void)dateChanged:(UIDatePicker *)datePicker
{
    RegisterFormModel *registerFormModel = self.formModel;
    NSDate *date = datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString  *string = [[NSString alloc]init];
    string = [dateFormatter stringFromDate:date];
    NSLog(@"%@",string);
    registerFormModel.birthday = string;
    [self reloadTable];

}

#pragma mark 验证输入合法性
- (void)checkUserInputIsOk
{
    RegisterFormModel *registerFormModel = self.formModel;
    NSString *azID = registerFormModel.azID;
    if (!azID.length) {
        [self respondsToTextfieldWithKey:@"azID"];
        NSLog(@"請輸入用戶帳號");
        return;
    }
    if(azID.length<6){
        NSLog(@"帳戶ID不能少於6位");
        return;
    }else{
        NSString * AzEnglisth = [azID substringToIndex:1];
        NSString *countRegex = @"^[A-Za-z]{1,1}";
        NSPredicate *countTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countRegex];
        if (![countTest evaluateWithObject:AzEnglisth]) {
            NSLog(@"首字符必須是英文字母");
            return;
        }
    }

    NSString * pwd = registerFormModel.password;
    NSString * confirmPwd = registerFormModel.confirmPassword;
    if (pwd.length==0) {
        [self respondsToTextfieldWithKey:@"password"];
        NSLog(@"請輸入密碼");
        return;
    }
    if (confirmPwd.length==0) {
        [self respondsToTextfieldWithKey:@"confirmPassword"];
        NSLog(@"請輸入確認密碼");
        return;
    }
    if (![pwd isEqualToString:confirmPwd]) {
        NSLog(@"兩次輸入的密碼不一致");
        return;
    }
    if (registerFormModel.mobile.length == 0) {
        [self respondsToTextfieldWithKey:@"mobile"];
        NSLog(@"請輸入手機號碼");
        return;
    }
    
    //註冊
}

#pragma mark - YJFormTFDelegate
- (BOOL)yj_formTF:(UITextField *)tf shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string indexPath:(NSIndexPath *)indexPath item:(YJFormItem *)item
{
    NSString * textString = [tf.text stringByReplacingCharactersInRange:range withString:string];
    textString = [textString stringByReplacingOccurrencesOfString:@"\u2006" withString:@""];
    if ([item.key isEqualToString:@"azID"]) {  //账号
        if (textString.length>20) {
            NSLog(@"用戶帳號超過了20個限制");
            return NO;
        }
    }
    if ([item.key isEqualToString:@"password"]) {  //密码
        if (textString.length>20) {
            if ([string isEqualToString:@""]) {
                return YES;
            }else
            {
                NSLog(@"用戶密碼超過了20個限制");
            }
        }
    }
    if ([item.key isEqualToString:@"confirmPassword"]) {  //确认密码
        if (textString.length>20) {
            if ([string isEqualToString:@""]) {
                return YES;
            }else
            {
                NSLog(@"確認密碼超過了20個限制");
            }
        }
    }
    if ([item.key isEqualToString:@"nickName"]) {  //昵称
        if (textString.length>20) {
            NSLog(@"確認用戶昵稱超過了20個限制");
            return NO;
        }
    }
    if ([item.key isEqualToString:@"email"]) {  //邮箱
        if (textString.length>30) {
            NSLog(@"確認保密郵箱超過了30個限制");
            return NO;
        }
    }
    return YES;
}


@end

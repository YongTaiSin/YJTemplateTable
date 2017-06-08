//
//  YJBadgeButton.m
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/5/27.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//

#import "YJBadgeButton.h"
#define kBundlePath [[NSBundle mainBundle] pathForResource:@"YJCustomTable" ofType:@"bundle"]

@implementation YJBadgeButton
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[self resizableImage:[kBundlePath stringByAppendingPathComponent:@"main_badge"]] forState:UIControlStateNormal];
        self.hidden = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
      //  self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = NO;
    }
    return self;
}

#pragma mark - setter
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if (badgeValue&&[badgeValue intValue]!=0) {
        self.hidden = NO;
        
        //设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        //设置frame
        CGRect frame = self.frame;
        
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length>1) {
            CGSize badgeSize = [self getSizeOfString:badgeValue font:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, badgeH)];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        
        self.frame = frame;
        
    }else
    {
        self.hidden = YES;
    }
    
}

#pragma mark - methods
- (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat edgeW = normal.size.width * 0.5;
    CGFloat edgeH = normal.size.height * 0.5;
    return [normal stretchableImageWithLeftCapWidth:edgeW topCapHeight:edgeH];
}

- (CGSize)getSizeOfString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end

//
//  UIView+Frame.h
//  YJTemplateTableExample
//
//  Created by Jeremiah on 15/6/15.
//  Copyright (c) 2015年 Jeremiah. All rights reserved.
//
//  UIView分类，简化获取frame的x、y、width等值

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic,assign) CGFloat yj_x;
@property (nonatomic,assign) CGFloat yj_y;
@property (nonatomic,assign) CGFloat yj_centerX;
@property (nonatomic,assign) CGFloat yj_centerY;
@property (nonatomic,assign) CGFloat yj_width;
@property (nonatomic,assign) CGFloat yj_height;
@property (nonatomic,assign) CGSize yj_size;
@end

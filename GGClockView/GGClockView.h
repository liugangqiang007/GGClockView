//
//  GGClockView.h
//  抢购倒计时
//
//  Created by LGQ on 16/4/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import <UIKit/UIKit.h>

/***
     倒计时控件
     显示方式类似于电子时钟
     最低单位是秒
 ***/

@interface GGClockView : UIView

/// 初始时间
@property (nonatomic, assign) NSTimeInterval time;


/***** 配置 *****/
/// 文字区域背景色
@property (nonatomic, strong) UIColor *timeBackgroundColor;
/// 文字颜色
@property (nonatomic, strong) UIColor *timeTextColor;
/// 冒号颜色
@property (nonatomic, strong) UIColor *colonColor;
/// 字号
@property (nonatomic, strong) UIFont  *font;

/// 快速构造方法
+ (instancetype)clockViewWithTimeBackgroundColor:(UIColor *)timeBackgroundColor timeTextColor:(UIColor *)timeTextColor colonColor:(UIColor *)colonColor font:(UIFont *)font;
- (instancetype)initWithTimeBackgroundColor:(UIColor *)timeBackgroundColor timeTextColor:(UIColor *)timeTextColor colonColor:(UIColor *)colonColor font:(UIFont *)font;

/// 统一设置方法
- (void)setTimeBackgroundColor:(UIColor *)timeBackgroundColor timeTextColor:(UIColor *)timeTextColor colonColor:(UIColor *)colonColor font:(UIFont *)font;

@end

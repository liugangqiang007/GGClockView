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

typedef NS_ENUM(NSUInteger, GGClockViewContentMode) {
    GGClockViewContentModeRight,
    GGClockViewContentModeLeft,
    GGClockViewContentModeCenter,
};

@interface GGClockView : UIView

/****************************** 倒计时初始时间 ******************************/
@property (nonatomic, assign) NSTimeInterval time;

/****************************** 配置 ******************************/
/// 文字区域背景色
@property (nonatomic, strong) UIColor *timeBackgroundColor;
/// 文字颜色
@property (nonatomic, strong) UIColor *timeTextColor;
/// 冒号颜色
@property (nonatomic, strong) UIColor *colonColor;
/// 字号
@property (nonatomic, strong) UIFont  *font;
/// 内容显示位置
@property (nonatomic, assign) GGClockViewContentMode contentMode;
/// 当时间超过一天时，是否显示天, 默认否
@property (nonatomic, assign) BOOL isDisplayDay;

/****************************** 快速构造方法 ******************************/
+ (instancetype)clockViewWithTimeBackgroundColor:(UIColor *)timeBackgroundColor
                                   timeTextColor:(UIColor *)timeTextColor
                                      colonColor:(UIColor *)colonColor
                                            font:(UIFont *)font;
- (instancetype)initWithTimeBackgroundColor:(UIColor *)timeBackgroundColor
                              timeTextColor:(UIColor *)timeTextColor
                                 colonColor:(UIColor *)colonColor
                                       font:(UIFont *)font;

/// 统一设置外观
- (void)setTimeBackgroundColor:(UIColor *)timeBackgroundColor
                 timeTextColor:(UIColor *)timeTextColor
                    colonColor:(UIColor *)colonColor
                          font:(UIFont *)font;



/****************************** 控制 ******************************/
- (void)start;  // 开始
- (void)pause;  // 暂停
- (void)stop;   // 停止

@end

//
//  GGClockView.m
//  抢购倒计时
//
//  Created by LGQ on 16/4/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "GGClockView.h"

#define GGDefaultTimeBackgroundColor [UIColor colorWithRed:51/225.0 green:51/225.0 blue:51/225.0 alpha:1]
#define GGDefaultTimeTextColor       [UIColor whiteColor]
#define GGDefaultColonColor          [UIColor colorWithRed:51/225.0 green:51/225.0 blue:51/225.0 alpha:1]
#define GGDefaultFont [UIFont boldSystemFontOfSize:12]

@interface GGClockView ()

@property (nonatomic, weak) UILabel *hourLabel;
@property (nonatomic, weak) UILabel *minuteLabel;
@property (nonatomic, weak) UILabel *secondLabel;

@property (nonatomic, weak) UILabel *leftColonLabel;
@property (nonatomic, weak) UILabel *rigthColonLabel;

/// 计时器
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation GGClockView

+ (instancetype)clockViewWithTimeBackgroundColor:(UIColor *)timeBackgroundColor
                                   timeTextColor:(UIColor *)timeTextColor
                                      colonColor:(UIColor *)colonColor
                                            font:(UIFont *)font {
    return [[self alloc] initWithTimeBackgroundColor:timeBackgroundColor
                                       timeTextColor:timeTextColor
                                          colonColor:colonColor
                                                font:font];
}


- (instancetype)initWithTimeBackgroundColor:(UIColor *)timeBackgroundColor
                              timeTextColor:(UIColor *)timeTextColor
                                 colonColor:(UIColor *)colonColor
                                       font:(UIFont *)font {
    if (self = [self initWithFrame:CGRectZero]) {
        [self setTimeBackgroundColor:timeBackgroundColor
                       timeTextColor:timeTextColor
                          colonColor:colonColor
                                font:font];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        if (CGSizeEqualToSize(frame.size, CGSizeZero)) {
            frame.size = CGSizeMake(80, 25);
            self.frame = frame;
        }
        self.timeBackgroundColor = GGDefaultTimeBackgroundColor;
        self.timeTextColor       = GGDefaultTimeTextColor;
        self.colonColor          = GGDefaultColonColor;
        self.font                = GGDefaultFont;
        self.time                = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat heigth      = self.frame.size.height;
    CGFloat colonLabelW = 7.5;
    CGFloat timeLabelW  = (self.frame.size.width - 2 * colonLabelW) / 3.0;
    
    CGFloat hourLabelX       = 0;
    CGFloat leftColonLabelX  = hourLabelX + timeLabelW;
    CGFloat minuteLabelX     = leftColonLabelX + colonLabelW;
    CGFloat rigthColonLabelX = minuteLabelX + timeLabelW;
    CGFloat secondLabelX     = rigthColonLabelX + colonLabelW;
    
    self.hourLabel.frame       = CGRectMake(hourLabelX, 0, timeLabelW, heigth);
    self.minuteLabel.frame     = CGRectMake(minuteLabelX, 0, timeLabelW, heigth);
    self.secondLabel.frame     = CGRectMake(secondLabelX, 0, timeLabelW, heigth);
    
    self.leftColonLabel.frame  = CGRectMake(leftColonLabelX, 0, colonLabelW, heigth);
    self.rigthColonLabel.frame = CGRectMake(rigthColonLabelX, 0, colonLabelW, heigth);
    
}

#pragma mark - personal
- (void)timeRun {
    
    if (_time <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        _time = 0;
    } else {
        _time --;
    }
    
    [self setViewWith:_time];
}

- (void)setTimeBackgroundColor:(UIColor *)timeBackgroundColor timeTextColor:(UIColor *)timeTextColor colonColor:(UIColor *)colonColor font:(UIFont *)font {
    
    self.timeBackgroundColor = timeBackgroundColor;
    self.timeTextColor = timeTextColor;
    self.colonColor = colonColor;
    self.font = font;
}

- (void)setViewWith:(NSTimeInterval)time {

    NSInteger hour = time/3600.0;
    NSInteger min  = (time - hour*3600)/60;
    NSInteger sec  = time - hour*3600 - min*60;
    
    self.hourLabel.text   = [NSString stringWithFormat:@"%02tu",hour];
    self.minuteLabel.text = [NSString stringWithFormat:@"%02tu",min];
    self.secondLabel.text = [NSString stringWithFormat:@"%02tu",sec];
}

- (UILabel *)timeLabel {
    UILabel *label = [[UILabel alloc] init];
    
    label.backgroundColor = self.timeBackgroundColor;
    label.textColor       = self.timeTextColor;
    label.font            = self.font;
    label.textAlignment   = NSTextAlignmentCenter;
    
    label.layer.cornerRadius  = 2;
    label.layer.masksToBounds = YES;
    return label;
}

- (UILabel *)colonLabel {
    UILabel *label = [[UILabel alloc] init];
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor       = self.colonColor;
    label.font            = self.font;
    label.text            = @":";
    label.textAlignment   = NSTextAlignmentCenter;
    
    return label;
}

#pragma mark - setter
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    
    [self setViewWith:_time];
    
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
    
}

- (void)setTimeBackgroundColor:(UIColor *)timeBackgroundColor {
    _timeBackgroundColor = timeBackgroundColor ? timeBackgroundColor : GGDefaultTimeBackgroundColor;
    
    self.hourLabel.backgroundColor   = _timeBackgroundColor;
    self.minuteLabel.backgroundColor = _timeBackgroundColor;
    self.secondLabel.backgroundColor = _timeBackgroundColor;
}

- (void)setTimeTextColor:(UIColor *)timeTextColor {
    _timeTextColor = timeTextColor ? timeTextColor : GGDefaultTimeTextColor;
    
    self.hourLabel.textColor   = _timeTextColor;
    self.minuteLabel.textColor = _timeTextColor;
    self.secondLabel.textColor = _timeTextColor;
}

- (void)setColonColor:(UIColor *)colonColor {
    _colonColor = colonColor ? colonColor : GGDefaultColonColor;
    
    self.leftColonLabel.textColor  = _colonColor;
    self.rigthColonLabel.textColor = _colonColor;
}

- (void)setFont:(UIFont *)font {
    _font = font ? font : GGDefaultFont;
    
    self.hourLabel.font       = _font;
    self.minuteLabel.font     = _font;
    self.secondLabel.font     = _font;
    self.leftColonLabel.font  = _font;
    self.rigthColonLabel.font = _font;
}

#pragma mark - getter
- (UILabel *)hourLabel {
    if (_hourLabel == nil) {
        UILabel *hourLabel = [self timeLabel];
        [self addSubview:hourLabel];
        _hourLabel = hourLabel;
    }
    return _hourLabel;
}

- (UILabel *)minuteLabel {
    if (_minuteLabel == nil) {
        UILabel *minuteLabel = [self timeLabel];
        [self addSubview:minuteLabel];
        _minuteLabel = minuteLabel;
    }
    return _minuteLabel;
}

- (UILabel *)secondLabel {
    if (_secondLabel == nil) {
        UILabel *secondLabel = [self timeLabel];
        [self addSubview:secondLabel];
        _secondLabel = secondLabel;
    }
    return _secondLabel;
}

- (UILabel *)leftColonLabel {
    if (_leftColonLabel == nil) {
        UILabel *leftColonLabel = [self colonLabel];
        [self addSubview:leftColonLabel];
        _leftColonLabel = leftColonLabel;
    }
    return _leftColonLabel;
}

- (UILabel *)rigthColonLabel {
    if (_rigthColonLabel == nil) {
        UILabel *rigthColonLabel = [self colonLabel];
        [self addSubview:rigthColonLabel];
        _rigthColonLabel = rigthColonLabel;
    }
    return _rigthColonLabel;
}

@end

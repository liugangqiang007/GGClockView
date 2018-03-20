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
#define GGDefaultFont                [UIFont boldSystemFontOfSize:10]
#define GGDefaultSpacing             6

@interface GGClockView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, weak) UILabel *hourLabel;
@property (nonatomic, weak) UILabel *minuteLabel;
@property (nonatomic, weak) UILabel *secondLabel;

@property (nonatomic, weak) UILabel *leftColonLabel;
@property (nonatomic, weak) UILabel *rigthColonLabel;

/// 计时器
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat labelW;

@end

@implementation GGClockView

#pragma mark - initialization and personal
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

- (void)setTimeBackgroundColor:(UIColor *)timeBackgroundColor timeTextColor:(UIColor *)timeTextColor colonColor:(UIColor *)colonColor font:(UIFont *)font {
    
    self.timeBackgroundColor = timeBackgroundColor;
    self.timeTextColor       = timeTextColor;
    self.colonColor          = colonColor;
    self.font                = font;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.timeBackgroundColor = GGDefaultTimeBackgroundColor;
        self.timeTextColor       = GGDefaultTimeTextColor;
        self.colonColor          = GGDefaultColonColor;
        self.font                = GGDefaultFont;
        self.isDisplayDay        = NO;
        self.time                = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.hourLabel sizeToFit];
    
    CGFloat hourLabelW = self.hourLabel.frame.size.width + GGDefaultSpacing;
    if (hourLabelW < self.labelW) {
        hourLabelW = self.labelW;
    }
    CGFloat heigth      = self.frame.size.height;
    CGFloat colonLabelW = 8;
    
    CGFloat hourLabelX       = 0;
    CGFloat leftColonLabelX  = hourLabelX + hourLabelW;
    CGFloat minuteLabelX     = leftColonLabelX + colonLabelW;
    CGFloat rigthColonLabelX = minuteLabelX + self.labelW;
    CGFloat secondLabelX     = rigthColonLabelX + colonLabelW;
    
    self.hourLabel.frame       = CGRectMake(hourLabelX, 0, hourLabelW, heigth);
    self.minuteLabel.frame     = CGRectMake(minuteLabelX, 0, self.labelW, heigth);
    self.secondLabel.frame     = CGRectMake(secondLabelX, 0, self.labelW, heigth);
    
    self.leftColonLabel.frame  = CGRectMake(leftColonLabelX, 0, colonLabelW, heigth);
    self.rigthColonLabel.frame = CGRectMake(rigthColonLabelX, 0, colonLabelW, heigth);
    
    CGFloat contentW = CGRectGetMaxX(self.secondLabel.frame);
    
    switch (self.contentMode) {
        case GGClockViewContentModeLeft:
            self.contentView.frame = CGRectMake(0, 0, contentW, self.bounds.size.height);
            break;
        case GGClockViewContentModeRight:
            self.contentView.frame = CGRectMake(self.bounds.size.width - contentW, 0, contentW, self.bounds.size.height);
            break;
        case GGClockViewContentModeCenter:
            self.contentView.frame = CGRectMake((self.bounds.size.width - contentW) / 2, 0, contentW, self.bounds.size.height);
            break;
    }
    
}

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

- (void)setViewWith:(NSTimeInterval)time {
    
    NSInteger day  = self.isDisplayDay ? time/(3600 * 24) : 0;
    NSInteger hour = (time - day * 3600 * 24) / 3600.0;
    NSInteger min  = (time - day * 3600 * 24 - hour * 3600) / 60;
    NSInteger sec  = time - day * 3600 * 24 - hour * 3600 - min * 60;
    
    if (day > 0) {
        self.hourLabel.text   = [NSString stringWithFormat:@"%02tu天%02tu", day, hour];
    } else {
        self.hourLabel.text   = [NSString stringWithFormat:@"%02tu",hour];
    }
    self.minuteLabel.text = [NSString stringWithFormat:@"%02tu",min];
    self.secondLabel.text = [NSString stringWithFormat:@"%02tu",sec];
    [self layoutSubviews];
}

#pragma mark - action
- (void)start {
    
    [self.timer invalidate];    
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)pause {
    [self.timer invalidate];
}

- (void)stop {
    [self.timer invalidate];
    self.time = 0;
}

#pragma mark - setter
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    
    [self setViewWith:_time];
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
    
    CGRect rect = [@"00" boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.minuteLabel.font,NSFontAttributeName, nil] context:nil];
    self.labelW = rect.size.width + GGDefaultSpacing;
}

#pragma mark - lazy
- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}


- (UILabel *)hourLabel {
    if (_hourLabel == nil) {
        UILabel *hourLabel = [self timeLabel];
        [self.contentView addSubview:hourLabel];
        _hourLabel = hourLabel;
    }
    return _hourLabel;
}

- (UILabel *)minuteLabel {
    if (_minuteLabel == nil) {
        UILabel *minuteLabel = [self timeLabel];
        [self.contentView addSubview:minuteLabel];
        _minuteLabel = minuteLabel;
    }
    return _minuteLabel;
}

- (UILabel *)secondLabel {
    if (_secondLabel == nil) {
        UILabel *secondLabel = [self timeLabel];
        [self.contentView addSubview:secondLabel];
        _secondLabel = secondLabel;
    }
    return _secondLabel;
}

- (UILabel *)leftColonLabel {
    if (_leftColonLabel == nil) {
        UILabel *leftColonLabel = [self colonLabel];
        [self.contentView addSubview:leftColonLabel];
        _leftColonLabel = leftColonLabel;
    }
    return _leftColonLabel;
}

- (UILabel *)rigthColonLabel {
    if (_rigthColonLabel == nil) {
        UILabel *rigthColonLabel = [self colonLabel];
        [self.contentView addSubview:rigthColonLabel];
        _rigthColonLabel = rigthColonLabel;
    }
    return _rigthColonLabel;
}

#pragma mark - others
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

@end

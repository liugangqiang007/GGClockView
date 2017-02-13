//
//  ViewController.m
//  抢购倒计时
//
//  Created by LGQ on 16/4/11.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ViewController.h"
#import "GGClockView.h"

@interface ViewController ()
@property (nonatomic, strong) GGClockView *clockView;
@property (nonatomic, assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    
    // 创建倒计时器
    self.clockView = [GGClockView clockViewWithTimeBackgroundColor:[UIColor grayColor]
                                                     timeTextColor:[UIColor whiteColor]
                                                        colonColor:nil
                                                              font:[UIFont systemFontOfSize:12]];
    [self.view addSubview:self.clockView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.clockView.frame = CGRectMake(100, 100, 80, 25);
}

#pragma mark - 控制方法
- (void)tapAction {
    NSInteger action = self.index % 4;
    switch (action) {
        case 0: // 开始计时
            // 赋值，单位秒
            self.clockView.time = 99999;
            [self.clockView start];
            break;
        case 1: // 暂停
            [self.clockView pause];
            break;
        case 2:
            [self.clockView start];
            break;
        case 3: // 停止计时，计时器归零
            [self.clockView stop];
            break;
    }
    self.index ++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end



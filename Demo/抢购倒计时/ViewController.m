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
@property (nonatomic, weak) GGClockView *clockView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    GGClockView *clockView = [[GGClockView alloc] initWithTimeBackgroundColor:[UIColor greenColor] timeTextColor:[UIColor blueColor] colonColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]];
    clockView.frame = CGRectMake(100, 100, 200, 50);
    clockView.time = 100;
    [self.view addSubview:clockView];
    self.clockView = clockView;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end



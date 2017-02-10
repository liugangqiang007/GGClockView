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

    self.clockView = [[GGClockView alloc] init];
    self.clockView.frame = CGRectMake(100, 100, 80, 25);
    [self.view addSubview:self.clockView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

- (void)tapAction {
    NSInteger action = self.index % 4;
    switch (action) {
        case 0:
            self.clockView.time = 20;
            [self.clockView start];
            break;
        case 1:
            [self.clockView pause];
            break;
        case 2:
            [self.clockView start];
            break;
        case 3:
            [self.clockView stop];
            break;
    }
    self.index ++;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end



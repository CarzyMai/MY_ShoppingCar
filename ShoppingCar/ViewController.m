//
//  ViewController.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/15.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "ViewController.h"
#import "MY_ShoppingCarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我进购物车" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.bottom.equalTo(self.view).offset(-100);
    }];
}

- (void)buttonClicked:(UIButton *)sender {
    MY_ShoppingCarController *vc = [[MY_ShoppingCarController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

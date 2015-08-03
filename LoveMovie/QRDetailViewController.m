//
//  QRDetailViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15/8/1.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "QRDetailViewController.h"

@interface QRDetailViewController ()

@end

@implementation QRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}




@end

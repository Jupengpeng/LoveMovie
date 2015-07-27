//
//  LoveMovieTabBarViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "LoveMovieTabBarViewController.h"
#import "BuyTicketViewController.h"
#import "MallViewController.h"
#import "FindViewController.h"
#import "MineViewController.h"
#import "HomePageViewController.h"
@interface LoveMovieTabBarViewController ()

@end

@implementation LoveMovieTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titleArr = @[@"首页",@"购票",@"商城",@"发现",@"我的"];
    NSArray * classArr = @[@"HomePageViewController",@"BuyTicketViewController",@"MallViewController",@"FindViewController",@"MineViewController"];
    
    NSMutableArray * controllersArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 5; i ++) {
        Class cls = NSClassFromString(classArr[i]);
        UITableViewController * controller =  [[cls alloc]init];
        UINavigationController * niv = [[UINavigationController alloc]initWithRootViewController:controller];
        controller.title = titleArr[i];
        
        [controllersArr addObject:niv];
    }
    
    
    self.viewControllers = controllersArr;
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

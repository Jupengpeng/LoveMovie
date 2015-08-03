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
#import "CountainerControler.h"
@interface LoveMovieTabBarViewController ()

@end

@implementation LoveMovieTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titleArr = @[@"首页",@"购票",@"发现",@"我的"];
    NSArray * classArr = @[@"HomePageViewController",@"BuyTicketViewController",@"CountainerControler",@"MineViewController"];
    NSArray * imagesArr = @[@"home_on",@"payticket_on",@"discover_on",@"myinfo_on"];
    NSMutableArray * controllersArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 4; i ++) {
        Class cls = NSClassFromString(classArr[i]);
        UITableViewController * controller =  [[cls alloc]init];
        UINavigationController * niv = [[UINavigationController alloc]initWithRootViewController:controller];
        
        niv.tabBarItem.image = [UIImage imageNamed:imagesArr[i]];

        
        controller.title = titleArr[i];
        
        [controllersArr addObject:niv];
    }
//    @[@"tabbar_icon_news_highlight",@"tabbar_icon_reader_highlight",@"tabbar_icon_found_highlight",@"tabbar_icon_me_highlight"];
    
//    self.tabBarController.tabBar.barTintColor = myRed;
    
    self.viewControllers = controllersArr;
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

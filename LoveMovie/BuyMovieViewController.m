//
//  BuyMovieViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-20.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyMovieViewController.h"
#import "SCNavTabBarController.h"
@interface BuyMovieViewController ()

@end

@implementation BuyMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BuyHotViewController * hotController = [[BuyHotViewController alloc]init];
    hotController.title = @"正在热映";
    hotController.currentCityId = self.currentCityId;
    hotController.myCoordinate = self.myCoordinate;
    BuyComingViewController * comingController=  [[BuyComingViewController alloc]init];
    comingController.title = @"即将上映";
    comingController.currentCityId = self.currentCityId;
    SCNavTabBarController * navTabBarController  = [[SCNavTabBarController alloc]init];
    navTabBarController.scNavFrame = CGRectMake(0, 64, kScreenSize.width, 35);
    navTabBarController.navTabBarColor = myGray;
    navTabBarController.navTabBarLineColor = myRed;
    navTabBarController.subViewControllers = @[hotController,comingController];
    [navTabBarController addParentController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

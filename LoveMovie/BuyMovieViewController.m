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
    
    [self initSubControllers];
}

- (void)initSubControllers{
    self.hotController = [[BuyHotViewController alloc]init];
    self.hotController.title = @"正在热映";
    self.hotController.currentCityId = self.currentCityId;
    self.hotController.myCoordinate = self.myCoordinate;
    self.comingController=  [[BuyComingViewController alloc]init];
    self.comingController.title = @"即将上映";
    self.comingController.currentCityId = self.currentCityId;
    SCNavTabBarController * navTabBarController  = [[SCNavTabBarController alloc]init];
    navTabBarController.scNavFrame = CGRectMake(0, 64, kScreenSize.width, 35);
    navTabBarController.navTabBarColor = myGray;
    navTabBarController.navTabBarLineColor = myRed;
    navTabBarController.subViewControllers = @[self.hotController,self.comingController];
    [navTabBarController addParentController:self];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

//
//  CountainerControler.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "CountainerControler.h"
@interface CountainerControler ()
{
    SCNavTabBarController * _container;
}
@end

@implementation CountainerControler

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
}

- (void)initUI{
    NSMutableArray * viewControllers = [[NSMutableArray alloc]init];
    NSArray * controllerNames = [[NSArray alloc]initWithObjects:@"NewsViewController",@"ForeDisplayViewController",@"SortBoardViewController",@"FindCommentsViewController", nil];
    NSArray * titleArray = [NSArray arrayWithObjects:@"新闻",@"预告片",@"排行榜",@"影评",nil];
    
    NSArray * typeArr = @[kNewType,kForeType,kSortType,kReviewType];
    //影评和排行榜 有index参数
    NSArray * urlArr  = @[kFindNewsUrl,kForeDisplayUrl,kSortBoardUrl,kFindCommentUrl];
    for (int i = 0 ; i < titleArray.count; i ++) {
        
        Class cls = NSClassFromString(controllerNames[i]);
        FindViewController * controller= [[cls alloc]init];
        controller.url = urlArr[i];
        controller.type = typeArr[i];
        controller.title = titleArray[i];
        [viewControllers addObject:controller];
    }
    _container =  [[SCNavTabBarController alloc]init];
    _container.subViewControllers = viewControllers;
    _container.scNavFrame = CGRectMake(0, 0, kScreenSize.width, 64);
    _container.navTabBarColor = myRed;
    _container.navTabBarLineColor = [UIColor whiteColor];
    [_container addParentController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

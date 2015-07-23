//
//  GaodeViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-22.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "GaodeViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface GaodeViewController ()<MAMapViewDelegate>
{
    MAMapView * _mapView;
    
    //高德的搜索 POI
    AMapSearchAPI *_search;
}
@end

@implementation GaodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//配置用户key
    [MAMapServices sharedServices].apiKey = @"e2b477e69ba80071adf4fe45a2b7208d";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self; [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end

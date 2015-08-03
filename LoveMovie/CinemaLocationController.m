//
//  CinemaLocationController.m
//  LoveMovie
//
//  Created by qianfeng on 15/8/2.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "CinemaLocationController.h"

@interface CinemaLocationController ()

@end

@implementation CinemaLocationController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self getCurrentLocation];
    
}

- (void)getCurrentLocation{
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        GaodeViewController * gaodeVC = [[GaodeViewController alloc]init];
        gaodeVC.coodinate = locationCorrrdinate;
        gaodeVC.cinemaName = @"电影院名字";
        gaodeVC.address = @"电影院地址";
        [self.navigationController pushViewController:gaodeVC animated:YES];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end

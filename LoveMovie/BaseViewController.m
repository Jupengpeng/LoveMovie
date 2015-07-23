//
//  BaseViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface BaseViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager * _manager;
    
}

@property (nonatomic,strong) CLLocationManager * manager;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//设置导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//设置状态栏颜色
    
    self.navigationController.navigationBar.barTintColor = myRed;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self initLocationManager];

    
    
    
}



- (void)initLocationManager{
    if (!self.manager) {
        self.manager = [[CLLocationManager alloc]init];
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.manager.distanceFilter = 1;
        
        CGFloat version = [[[UIDevice currentDevice] systemVersion]floatValue];
        if (version>=8.0) {
            //申请用户授权位置信息
            [self.manager requestAlwaysAuthorization];
        }
        self.manager.delegate = self;
        
    }
    
    
}

- (void)beginLocation{
    //是否支持定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        [self.manager startUpdatingLocation];
    }else{
        BBLog(@"没有gps");
    }
    
}

- (void)endLocation{
    
    [self.manager stopUpdatingLocation];
    
}
#pragma mark -<CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation * location = [locations lastObject ];
    self.coordinate = location.coordinate;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end

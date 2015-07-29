//
//  BaseViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets= YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //设置导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//设置状态栏颜色
    
    self.navigationController.navigationBar.barTintColor = myRed;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    

}



//计算距离
- (double)getDistanceFrom:(CLLocationCoordinate2D)origCoordonate toDistWithLatitude:(CLLocationDegrees)latitude Longitude:(CLLocationDegrees)longitude{
    
    CLLocation * orig = [[CLLocation alloc] initWithLatitude:origCoordonate.latitude  longitude:origCoordonate.longitude];
    CLLocation * dist = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist]/1000;
    
    return kilometers;
}

- (void)exchangeArray:(NSMutableArray *)array WithIndex1:(NSInteger)index1 index2:(NSInteger)index2{
    NSObject * object  = [array objectAtIndex:index1];
    [array replaceObjectAtIndex:index1 withObject:[array objectAtIndex:index2]];
    [array replaceObjectAtIndex:index2 withObject:object];
    
    
}

//增加 titleView
- (void)addTitleViewWithTitle:(NSString *)title {
    UILabel *titleLabel = [MyControl creatLabelWithFrame:CGRectMake(0, 0, 200, 30) text:title];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:19];
    
    //设置titleView
    self.navigationItem.titleView = titleLabel;
    
}

//2015-07-26 --> 20150726
- (NSString *)firstTransformTimeWithStr:(NSString *)timeStr{
    NSString * neededTime  = @"";
    NSArray * strArr = [timeStr componentsSeparatedByString:@"-"];
    for (NSString * str in strArr) {
        neededTime = [neededTime stringByAppendingString:str];
    }
    return neededTime;
}

- (NSString *)secondTransformTimeWithStr:(NSString *)timeStr{
    NSString * neededTime  = @"";
    NSMutableArray * strArr =[NSMutableArray arrayWithArray:[timeStr componentsSeparatedByString:@"-"]];
    [strArr removeObjectAtIndex:0];
    neededTime = [NSString stringWithFormat:@"%@月%@日",strArr[0],strArr[1]];
    return neededTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end

//
//  BaseViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPControl.h"
#import "CCLocationManager.h"
#import "LocationModel.h"
#import "MyControl.h"
@interface BaseViewController : UIViewController

@property (nonatomic,strong) LocationModel * locationModel;

//增加 titleView
- (void)addTitleViewWithTitle:(NSString *)title;

//计算距离
- (double)getDistanceFrom:(CLLocationCoordinate2D)origCoordonate toDistWithLatitude:(CLLocationDegrees)latitude Longitude:(CLLocationDegrees)longitude;

- (void)exchangeArray:(NSMutableArray *)array WithIndex1:(NSInteger)index1 index2:(NSInteger)index2;

- (NSString *)firstTransformTimeWithStr:(NSString *)timeStr;

- (NSString *)secondTransformTimeWithStr:(NSString *)timeStr;

@end

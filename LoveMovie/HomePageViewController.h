//
//  HomePageViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-18.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "LocationViewController.h"

@interface HomePageViewController : BaseViewController

@property (nonatomic)int currentCityId ;

@property (nonatomic,strong) UIBarButtonItem * locationBtn;


@end

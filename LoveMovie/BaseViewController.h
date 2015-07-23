//
//  BaseViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPControl.h"
#import <CoreLocation/CoreLocation.h>

@interface BaseViewController : UIViewController

@property (nonatomic)    CLLocationCoordinate2D coordinate ;

- (void)beginLocation;
- (void)endLocation;
@end

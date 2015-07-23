//
//  HomeScrollCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-17.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPControl.h"
#import "HomeAdvModel.h"
#import "HomePageModel.h"
#import "UIButton+WebCache.h"
@interface HomeScrollCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView * firstImageView;
@property (nonatomic,strong) UIImageView * secondImageView;

@property (nonatomic,strong) UIScrollView * myScrollView;
@property (nonatomic,strong) UIImageView * imageView1;
@property (nonatomic,strong) UIImageView * imageView2;
@property (nonatomic,strong) UIImageView * imageView3;
@property (nonatomic,strong) UIImageView * imageView4;
- (void) showDataWithAdvModel:(HomePageModel *)model;


@end

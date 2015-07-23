//
//  HomeHeaderCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+LBBlurredImage.h"
#import "AFNetworking.h"
#import "HomeHeaderModel.h"
#import "HomeHeaderMovieModel.h"
#import "UIImageView+WebCache.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"

@interface HomeHeaderView : UITableViewCell<OTPageScrollViewDataSource,OTPageScrollViewDelegate>

{
    AFHTTPRequestOperationManager * _manager;
    UIImageView * _imageView;
}



@property (nonatomic,strong) UIImageView * myImageView;
@property (nonatomic,strong) OTPageView * myScrollView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIImageView * ratingImageView;
@property (nonatomic,strong) UILabel * ratingLabel;
@property (nonatomic,strong) UILabel * myLabel;
@property (nonatomic,strong) UIButton * buyButton;
@property (nonatomic,strong) UILabel * specialLabel;
@property (nonatomic,strong) UIButton * button1;
@property (nonatomic,strong) UIButton * button2;
@property (nonatomic,strong) UIButton * button3;
@property (nonatomic,strong) UILabel * totalHotLabel;
@property (nonatomic,strong) UILabel * totalComingLabel;
@property (nonatomic,strong) UILabel * totalCinemaLabel;

@property (nonatomic,strong) UIView * buttonLabel;

@property (nonatomic,strong) NSMutableArray * imageViewArr;

@property (nonatomic,strong) HomeHeaderModel * headerModel;
- (void)showHomeHeaderCellDataWithHeaderModel:(HomeHeaderModel *)headerModel;
@end

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
#import "BuyHotViewController.h"
#import "BuyComingViewController.h"
#import "BuyCinemaViewController.h"
#import "BuyMovieDetailController.h"
#import "MyMovieDetailController.h"


typedef void (^MyJumpBuyTicketBlock) (int movieId);
typedef void (^MyClickMovieBlock) (int movieId);

@interface HomeHeaderView : UITableViewCell<OTPageScrollViewDataSource,OTPageScrollViewDelegate>

{
    AFHTTPRequestOperationManager * _manager;
    UIImageView * _imageView;

    
    MyJumpBuyTicketBlock _myBuyBlock;
    MyClickMovieBlock _myMovieBlock;
}

@property (nonatomic) UINavigationController * nivController;
@property (nonatomic,strong) UITabBarController * tabController;


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

@property (nonatomic) int movieId ;
@property (nonatomic) int locationId ;
@property (nonatomic,copy) NSString * movieTitle;


- (void)showHomeHeaderCellDataWithHeaderModel:(HomeHeaderModel *)headerModel;

- (void)setMyBuyHotBlock:(MyJumpBuyTicketBlock)myBlock;

- (void)setMyClickMovieBlock:(MyClickMovieBlock)myBlock;
@end

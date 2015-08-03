//
//  ReviewDetailViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "ReviewDetailModel.h"
#import "ReviewDetaiObjModel.h"
#import "AFNetworking.h"
#import "NewsCommentsController.h"
#import "LZXHelper.h"
#import "UIButton+WebCache.h"
@interface ReviewDetailViewController : BaseViewController


@property (nonatomic) int reviewId ;

@property (nonatomic,strong) UILabel * numberLabel;

@property (nonatomic,strong)ReviewDetailModel * reviewDetModel;

@property (nonatomic,strong) UIView * relationView;

@property (nonatomic,strong) UIView * blackView;

@property (nonatomic,strong) ReviewDetaiObjModel * reviewDetaiObjModel;

@end

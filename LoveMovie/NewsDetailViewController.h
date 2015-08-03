//
//  NewsDetailViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"
#import "NewDetailModel.h"
#import "RelationsModel.h"
#import "NewsImageModel.h"
#import "LZXHelper.h"
#import "NewsCommentsController.h"
#import "JPControl.h"
#import "UIButton+WebCache.h"
@interface NewsDetailViewController : BaseViewController

@property (nonatomic) int newsId;;

@property (nonatomic,strong) UILabel * numberLabel;

@property (nonatomic,strong)NewDetailModel * newsDetailModel;

@property (nonatomic,strong) UIView * relationView;

@property (nonatomic,strong) UIView * blackView;

@property (nonatomic,strong) UIScrollView * imagesScrollView ;

@property (nonatomic,strong) UIButton * contentBtn ;

@property (nonatomic,copy) NSMutableString * content;

@end

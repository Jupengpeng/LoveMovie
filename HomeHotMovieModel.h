//
//  HomeHotMovieModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "HomeMovieModel.h"
@interface HomeHotMovieModel : JSONModel


@property (nonatomic,copy) NSString * topCover;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,strong) HomeMovieModel * movie;


@end

//
//  HomeHeaderModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-18.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface HomeHeaderModel : BaseModel

@property (nonatomic) int totalHotMovie;

@property (nonatomic) int totalComingMovie;

@property (nonatomic) int totalCinemaCount;

@property (nonatomic) int count;

@property (nonatomic,strong) NSArray * movies;


@end

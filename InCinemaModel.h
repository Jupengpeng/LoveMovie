//
//  InCinemaModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/25.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface InCinemaModel : BaseModel


@property (nonatomic) int cinemaId ;
@property (nonatomic) int movieId ;
@property (nonatomic) int movieLength ;
@property (nonatomic) int salePrice ;

@property (nonatomic,copy) NSString * cinemaName;
@property (nonatomic,copy) NSString * movieName;
@property (nonatomic,copy) NSString * hallName;
@property (nonatomic,copy) NSString * versionDesc;
@property (nonatomic,copy) NSString * language;
@property (nonatomic,strong) NSArray * seat;
//有多少列
@property (nonatomic) int seatColumnCount ;
//有多少行
@property (nonatomic) int seatRowCount ;


@end

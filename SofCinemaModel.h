//
//  SofCinemaModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface SofCinemaModel : BaseModel

@property (nonatomic)int sid ;
@property (nonatomic)int showDay ;
@property (nonatomic)int version ;
@property (nonatomic)int length ;
@property (nonatomic)int cinemaPrice ;
@property (nonatomic)int salePrice ;
@property (nonatomic)int hallID ;
@property (nonatomic)int endTime ;
@property (nonatomic)int startTime ;
@property (nonatomic)int isSeatLess ;
@property (nonatomic,copy) NSString * versionDesc;
@property (nonatomic,copy) NSString * language;
@property (nonatomic,copy) NSString * hall;
@property (nonatomic,copy) NSString * price;
@property (nonatomic) BOOL isMovies;
@property (nonatomic) BOOL isCoupon;
@property (nonatomic) BOOL isTicket;
@property (nonatomic) BOOL isVaildTicket;
@property (nonatomic)int spaceTime ;
@property (nonatomic,strong) NSArray * provider;

@end

//
//  BuyMsModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface BuyMsModel : BaseModel


@property (nonatomic)int id ;
@property (nonatomic)int r ;
@property (nonatomic)int  NearestCinemaCount;
@property (nonatomic)int NearestShowtimeCount ;

@property (nonatomic,copy) NSString * tCn;

@property (nonatomic,copy) NSString * tEn;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * dN;
@property (nonatomic,copy) NSString * aN1;
@property (nonatomic,copy) NSString * aN2;
@property (nonatomic,copy) NSString * rd;
@property (nonatomic,copy) NSString * d;
@property (nonatomic,copy) NSString * commonSpecial;
@property (nonatomic,copy) NSString * movieType;
@property (nonatomic,strong) NSArray * p;
@property (nonatomic) int locationId ;





@end

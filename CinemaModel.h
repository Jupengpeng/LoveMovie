//
//  CinemaModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-22.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface CinemaModel : BaseModel


@property (nonatomic)int cinemaId ;
@property (nonatomic)int districtID ;
@property (nonatomic)float ratingFinal ;
@property (nonatomic)float longitude ;
@property (nonatomic)float latitude ;
@property (nonatomic)float baiduLongitude ;
@property (nonatomic)float baiduLatitude ;
@property (nonatomic)int movieCount ;
@property (nonatomic)int showtimeCount ;
@property (nonatomic)int minPrice ;
@property (nonatomic,copy) NSString * cinameName;
@property (nonatomic,copy) NSString * address;
@property (nonatomic) BOOL  isETicket;
@property (nonatomic) BOOL  isTicket;
@property (nonatomic,strong) NSDictionary * feature;


@property (nonatomic) float distance;

//正在热映添加model属性
@property (nonatomic) int cid;
@property (nonatomic,copy) NSString * cn;
@property (nonatomic) int cityId;
@property (nonatomic) int sC;
@property (nonatomic,strong) NSString * ln;
@property (nonatomic,strong) NSArray * recentDates;


//@property (nonatomic)int id ;
//@property (nonatomic)float latitude ;
//@property (nonatomic)float longitude ;
//@property (nonatomic)float baiduLatitude ;
//@property (nonatomic)float baiduLongitude ;
//@property (nonatomic)int districtId ;
//@property (nonatomic)int cityId ;
//@property (nonatomic)int provinceId ;
//@property (nonatomic,copy) NSString * name;
//@property (nonatomic,copy) NSString * address;
//@property (nonatomic,copy) NSString * tele;
//@property (nonatomic,copy) NSString * postCode;
//@property (nonatomic,copy) NSString * route;






@end

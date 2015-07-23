//
//  CinemaModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-22.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface CinemaModel : BaseModel

@property (nonatomic)int id ;
@property (nonatomic)float latitude ;
@property (nonatomic)float longitude ;
@property (nonatomic)float baiduLatitude ;
@property (nonatomic)float baiduLongitude ;
@property (nonatomic)int districtId ;
@property (nonatomic)int cityId ;
@property (nonatomic)int provinceId ;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * tele;
@property (nonatomic,copy) NSString * postCode;
@property (nonatomic,copy) NSString * route;






@end

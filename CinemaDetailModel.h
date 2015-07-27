//
//  CinemaDetailModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface CinemaDetailModel : BaseModel

@property (nonatomic,copy) NSString * cn;
@property (nonatomic,copy) NSString * address;
@property (nonatomic) float rating;
@property (nonatomic) BOOL isETicket;
@property (nonatomic,strong) NSArray * s;



@end

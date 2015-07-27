//
//  HomeNearestTime.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-18.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface HomeNearestTime : BaseModel

@property (nonatomic)int  nearestCinemaCount;
@property (nonatomic)int nearestShowtimeCount;
@property (nonatomic)int nearestShowDay;
@property (nonatomic) BOOL isTicket;



@end

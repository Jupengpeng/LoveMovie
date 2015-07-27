//
//  BuyHotMovieModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface BuyHotMovieModel : BaseModel

@property (nonatomic)int lid ;

@property (nonatomic,copy) NSString * bImg;

@property (nonatomic,copy) NSString * date;

@property (nonatomic,strong) NSArray * ms;

@end

//
//  TrailerHeaderModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface TrailerHeaderModel : BaseModel

@property (nonatomic) int trailerID ;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * imageUrl;
@property (nonatomic,copy) NSString * mp4Url;
@property (nonatomic,copy) NSString * hightUrl;
@property (nonatomic) int movieId ;

@end

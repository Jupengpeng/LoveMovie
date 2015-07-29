//
//  ReviewModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ReviewHeaderModel : BaseModel


@property (nonatomic) int reviewID ;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * posterUrl;
@property (nonatomic,copy) NSString * movieName;
@property (nonatomic,copy) NSString * imageUrl;

@end

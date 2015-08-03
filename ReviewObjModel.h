//
//  ReviewObjModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface ReviewObjModel : BaseModel

@property (nonatomic) int type ;
@property (nonatomic) int id ;
@property (nonatomic,copy) NSString * rating;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * image;


@end

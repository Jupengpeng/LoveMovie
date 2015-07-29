//
//  NewsImageModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface NewsImageModel : BaseModel

@property (nonatomic,copy) NSString * url1;
@property (nonatomic,copy) NSString * url2;
@property (nonatomic,copy) NSString * desc;
@property (nonatomic) int gId;

@end

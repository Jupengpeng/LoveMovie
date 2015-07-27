//
//  HomeHotImageModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"

@protocol HomeHotImageModel



@end

@interface HomeHotImageModel : JSONModel
@property (nonatomic,copy) NSString * url1;
@property (nonatomic,copy) NSString * url2;
@property (nonatomic,copy) NSString<Optional> * desc;
@end

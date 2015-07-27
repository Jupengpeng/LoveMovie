//
//  HomeHotPointModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "HomeHotImageModel.h"
@protocol HomeHotPointModel



@end

@interface HomeHotPointModel : JSONModel

@property (nonatomic)int id ;

@property (nonatomic)int type ;

@property (nonatomic,copy) NSString * desc;

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * img;

@property (nonatomic,strong)NSArray<Optional,HomeHotImageModel> * images;

@end

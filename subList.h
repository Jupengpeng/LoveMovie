//
//  subList.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"

@protocol  subListDelegate



@end


@interface subList : JSONModel

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * url;
@property (nonatomic) int goodsId ;


@end

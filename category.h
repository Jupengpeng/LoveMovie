//
//  category.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "subList.h"


@protocol  categoryDelegate



@end

@interface category : JSONModel

@property (nonatomic) int goodsId ;
@property (nonatomic,copy) NSString * moreUrl;
@property (nonatomic,copy) NSString * imageUrl;
@property (nonatomic,copy) NSString * image;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * colorValue;
@property (nonatomic,strong) NSArray<subListDelegate> * subList;


@end

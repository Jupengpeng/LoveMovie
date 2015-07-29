//
//  topic.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "subList.h"


@protocol  topicDelegate



@end


@interface topic : JSONModel

@property (nonatomic,copy) NSString * titleCn;
@property (nonatomic,copy) NSString * titleEn;
@property (nonatomic,copy) NSString * url;
@property (nonatomic) int goodsId;
@property (nonatomic,copy) NSString * checkedImage;
@property (nonatomic,copy) NSString * uncheckImage;
@property (nonatomic,copy) NSString * backgroundImage;
@property (nonatomic,strong) NSArray<subListDelegate> * subList;

@end

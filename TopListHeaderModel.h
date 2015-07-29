//
//  TopListModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseModel.h"

@interface TopListHeaderModel : BaseModel

@property (nonatomic) int id ;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * imageUrl;
@property (nonatomic) int type ;

@end

//
//  navigatorIcon.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"

@protocol navigatorIconDelegate



@end

@interface navigatorIcon : JSONModel

@property (nonatomic,copy) NSString * iconTitle;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * image;

@end

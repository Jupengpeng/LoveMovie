//
//  scrollImgModel.h
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"


@protocol scrollImgModelDelegate



@end

@interface scrollImgModel : JSONModel

@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * image;


@end

//
//  HomeAdvModel.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JSONModel.h"
#import "HomeGotoPageModel.h"
@protocol HomeAdvModel



@end

@interface HomeAdvModel : JSONModel

@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * img2;
@property (nonatomic,strong) HomeGotoPageModel * gotoPage;
@end

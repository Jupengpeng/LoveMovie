//
//  LocationViewController.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-23.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BaseViewController.h"
#import "AFNetworking.h"


typedef void (^MyLocationBlock) (LocationModel * locationModel);


@interface LocationViewController : BaseViewController
{
    
    MyLocationBlock _myBlock;
    
}
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) UILabel * currentLabel;

@property (nonatomic,strong) LocationModel * locationModel;

- (void)setMyBlock:(MyLocationBlock)myblock;

@end


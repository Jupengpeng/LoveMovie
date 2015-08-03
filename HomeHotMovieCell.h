//
//  HomeHotMovieCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHotMovieModel.h"
#import "UIImageView+WebCache.h"

typedef void (^MyHotMovieBlock) (int Id);


@interface HomeHotMovieCell : UITableViewCell
{
    MyHotMovieBlock _myMovieBlock;
}
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleCnLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleEnLabel;

@property (weak, nonatomic) IBOutlet UIImageView *littleImageView;



@property (nonatomic) UINavigationController * nivController;

@property (nonatomic,strong) UITabBarController * tabController;
@property (nonatomic) int movieId ;
@property (nonatomic,copy) NSString * movieTitle;

- (void)showDataWithHomeHotMovieModel:(HomeHotMovieModel *)model;
- (void)setMyHotBlock:(MyHotMovieBlock)myBlock;

@end

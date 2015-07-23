//
//  ComingMovCell.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-21.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComingMovieModel.h"
#import "UIImageView+WebCache.h"

typedef void (^MounthBlock) (int mounth);



@interface ComingMovCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *wantedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;
@property (weak, nonatomic) IBOutlet UIButton *beOnButton;
@property (weak, nonatomic) IBOutlet UIButton *foreshowButton;

@property (nonatomic,copy) MounthBlock myBlock;

- (void)showDataWithMovieModel:(ComingMovieModel *)movieModel;


@end

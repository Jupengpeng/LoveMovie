//
//  HomeHotMovieCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomeHotMovieCell.h"

@implementation HomeHotMovieCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)MOREBUTTON:(id)sender {
    BBLog(@"今日热点");
    
    
}
- (IBAction)movieButton:(UIButton *)sender {
    BBLog(@"电影");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showDataWithHomeHotMovieModel:(HomeHotMovieModel *)model{
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.topCover] placeholderImage:[UIImage imageNamed:@"empty"]];
    self.titleLabel.text = model.title;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.descLabel.text = model.movie.desc;
    self.descLabel.adjustsFontSizeToFitWidth = YES;
    self.titleCnLabel.text = model.movie.titleCn;
    self.titleCnLabel.adjustsFontSizeToFitWidth = YES;
    self.titleEnLabel.text = model.movie.titleEn;
    self.titleEnLabel.adjustsFontSizeToFitWidth= YES;
    [self.littleImageView sd_setImageWithURL:[NSURL URLWithString:model.movie.image] placeholderImage:[UIImage  imageNamed:@"empty"]];
    
    
}


@end

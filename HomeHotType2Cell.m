//
//  HomeHotType2Cell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomeHotType2Cell.h"

@implementation HomeHotType2Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showDataWithHomeHotPointModel:(HomeHotPointModel *)model{
    
    self.titleLabel.text = model.title;
    self.titleLabel.adjustsFontSizeToFitWidth= YES;
    self.descLabel.text = model.desc;
    [self.showImageView  sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"empty"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

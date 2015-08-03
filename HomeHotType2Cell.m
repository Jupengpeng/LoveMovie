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
    [self.showImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.showImageView.clipsToBounds = YES;
    self.titleLabel.adjustsFontSizeToFitWidth= YES;
}

- (void)showDataWithHomeHotPointModel:(HomeHotPointModel *)model{
    
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    [self.showImageView  sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"empty"]];
    
}

- (void)showDataWithNewsListModel:(NewsListModel *)model{
    if (!self.playIcon) {
        self.playIcon=  [[UIImageView alloc]initWithFrame:CGRectMake(self.showImageView.frame.size.width-42, self.showImageView.frame.size.height-42, 40,40)];
    }
    
    if (model.type==2) {
        self.playIcon.hidden = NO;
        self.playIcon.image = [UIImage imageNamed:kPlayIcon];
        [self.showImageView addSubview:self.playIcon];
    }else{
        self.playIcon.hidden = YES;
    }
            self.titleLabel.text = model.title;
            self.descLabel.text =[NSString stringWithFormat:@"%@\n                评论%d", model.title2,model.commentCount];
            [self.showImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"empty"]];

    
    
}

- (void)showDataWithForeDisPlayModel:(ForeDisPlayModel *)model{
        UIImageView * imageView=  [[UIImageView alloc]initWithFrame:CGRectMake(self.showImageView.frame.size.width-42, self.showImageView.frame.size.height-42, 40,40)];
        imageView.image = [UIImage imageNamed:kPlayIcon];
        [self.showImageView addSubview:imageView];
        
    self.titleLabel.text = model.movieName;
    self.descLabel.text =model.summary;
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:[UIImage imageNamed:@"empty"]];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

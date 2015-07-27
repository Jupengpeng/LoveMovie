//
//  HomeHotType1Cell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomeHotType1Cell.h"
@implementation HomeHotType1Cell

- (void)awakeFromNib {
    CGFloat orign = 15;
    CGFloat space =7;
    CGFloat w = (kScreenSize.width-44)/3;
    self.imageView1.frame = CGRectMake(orign, 60, w, 89);
    self.imageView1.clipsToBounds = YES;
    [self.imageView1 setContentMode:UIViewContentModeScaleAspectFill];
    self.imageView2.frame = CGRectMake(space +CGRectGetMaxX(self.imageView1.frame), 60, w, 89);
    self.imageView2.clipsToBounds = YES;
    [self.imageView2 setContentMode:UIViewContentModeScaleAspectFill];
    self.imageView3.frame = CGRectMake(space + CGRectGetMaxX(self.imageView2.frame), 60, w, 89);
    self.imageView3.clipsToBounds = YES;
    [self.imageView3 setContentMode:UIViewContentModeScaleAspectFill];

}

- (void)showDataWithHomeHotPointModel:(HomeHotPointModel *)model
{
    self.titleLabel.text = model.title;
    self.descLabel.text =  model.desc;
    HomeHotImageModel * imageModel1 = model.images[0];
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:imageModel1.url1] placeholderImage:[UIImage imageNamed: @"empty"]];
    HomeHotImageModel * imageModel2 = model.images[1];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:imageModel2.url1] placeholderImage:[UIImage imageNamed: @"empty"]];
    HomeHotImageModel * imageModel3 = model.images[2];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:imageModel3.url1] placeholderImage:[UIImage imageNamed: @"empty"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

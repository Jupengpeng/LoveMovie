//
//  areaSecondCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-15.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "areaSecondCell.h"

@implementation areaSecondCell

- (void)awakeFromNib {

    // self.frame = CGRectMake(0, 0, 100, 530);
    self.firstButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.firstButton.layer.borderWidth = 0.3f;
    self.secondButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.secondButton.layer.borderWidth = 0.3f;
    self.thirdButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.thirdButton.layer.borderWidth = 0.3f;
    self.fourthButtton.layer.borderColor = [UIColor grayColor].CGColor;
    self.fourthButtton.layer.borderWidth = 0.3f;

}
//将数据显示到cell
- (void)showDataWithAreaSecondModel:(HomeAreaSecondModel *)areaSecondModel{
    //为每个button下载图片
    [self.firstButton sd_setBackgroundImageWithURL:[NSURL URLWithString:areaSecondModel.subFirst.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed: @"empty"]];
    [self.secondButton sd_setBackgroundImageWithURL:[NSURL URLWithString:areaSecondModel.subSecond.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"]];
    [self.thirdButton sd_setBackgroundImageWithURL:[NSURL URLWithString:areaSecondModel.subThird.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"]];
    [self.fourthButtton sd_setBackgroundImageWithURL:[NSURL URLWithString:areaSecondModel.subFourth.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"]];
    [self.fifthButton sd_setBackgroundImageWithURL:[NSURL URLWithString:areaSecondModel.subFifth.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"]];
    
}

- (IBAction)firstBtnClick:(id)sender {
}

- (IBAction)secondBtnClick:(UIButton *)sender {
}

- (IBAction)thirdBtnClick:(UIButton *)sender {
}

- (IBAction)fourthButton:(UIButton *)sender {
}

- (IBAction)fifthBtnClick:(UIButton *)sender {
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end

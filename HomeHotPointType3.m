//
//  HomeHotPointType3.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-16.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomeHotPointType3.h"

@implementation HomeHotPointType3

- (void)awakeFromNib {
    self.firstButton.frame = CGRectMake(0, 0, kScreenSize.width/4, 44);
    self.secondButton.frame = CGRectMake(kScreenSize.width/4, 0, kScreenSize.width/4, 44);

    self.thirdButton.frame = CGRectMake(kScreenSize.width/2, 0, kScreenSize.width/4, 44);
    self.fourthButton.frame = CGRectMake(kScreenSize.width*3/4, 0, kScreenSize.width/4, 44);
    self.label.frame = CGRectMake(0, 44, kScreenSize.width, 5);
    self.firstButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.firstButton.layer.borderWidth = 0.3f;
    self.secondButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.secondButton.layer.borderWidth = 0.3f;
    self.thirdButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.thirdButton.layer.borderWidth = 0.3f;
    self.fourthButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.fourthButton.layer.borderWidth = 0.3f;

}
- (IBAction)firstBtnClick:(id)sender {
    
    [self.tabBarController setSelectedIndex:2];

    
}


- (IBAction)secondBtnClick:(id)sender {
    [self.tabBarController setSelectedIndex:2];
    
    
}
- (IBAction)thirdBtnClick:(id)sender {
    [self.tabBarController setSelectedIndex:2];
}
- (IBAction)fourthButton:(id)sender {
    [self.tabBarController setSelectedIndex:2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

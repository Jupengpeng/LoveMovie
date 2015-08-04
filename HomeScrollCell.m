//
//  HomeScrollCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-17.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomeScrollCell.h"

@implementation HomeScrollCell

- (void)awakeFromNib {

    self.myScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 5, kScreenSize.width, 88)];

//    self.myScrollView.pagingEnabled= YES;
    [self addSubview:self.myScrollView];

}

- (void) showDataWithAdvModel:(HomePageModel *)model
{
    for (int i = 0; i < model.advList.count; i ++) {
        UIButton * button = [[UIButton alloc]initWithFrame: CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, 88)];
        [self.myScrollView addSubview:button];
        
        self.myScrollView.showsHorizontalScrollIndicator = NO;
        self.myScrollView.contentSize = CGSizeMake(kScreenSize.width*i, 88);
        
        
        HomeAdvModel * advModel = model.advList[i];
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:advModel.img2 ] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"]];

    }


    

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

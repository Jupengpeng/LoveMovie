//
//  ComingHeaderCell.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-22.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "ComingHeaderCell.h"

@implementation ComingHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showHeaderDataWithMovieModel:(ComingMovieModel *)movieModel{
    
    [self processButton:self.sellButton];
    if (movieModel.videos.count) {
        self.foreshowButton.hidden=NO;
        [self processButton:self.foreshowButton];
        
        [self.foreshowButton setTitleColor:myPink forState:UIControlStateNormal];
        self.foreshowButton.backgroundColor = [UIColor whiteColor];
        [self.foreshowButton setTitle:@"预告片" forState:UIControlStateNormal];
    }else{
        self.foreshowButton.hidden = YES;
    }
    
    if (movieModel.isTicket) {
        [self.sellButton setTitle:@"超前预售" forState:UIControlStateNormal];
        [self.sellButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sellButton.backgroundColor = myPink;
    }else{
        [self.sellButton setTitle:@"敬请期待" forState:UIControlStateNormal];
        [self.sellButton setTitleColor:myPink forState:UIControlStateNormal];
        self.sellButton.enabled = YES;
        self.sellButton.backgroundColor = [UIColor whiteColor];
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d月%d日",movieModel.rMonth ,movieModel.rDay];
    self.titleLabel.text = movieModel.title;
    //为观看人数显示部分添加富文本
    NSString * wantedNum = [NSString stringWithFormat:@"%d",movieModel.wantedCount];
    NSString * wantedText = [NSString stringWithFormat:@"%@人想看 - %@",wantedNum,movieModel.type];
    
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:wantedText];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, wantedNum.length) ];
    self.wantedLanel.attributedText = attributeStr;

    
    self.directorLabel.text = [NSString stringWithFormat:@"导演：%@",movieModel.director];
    
    if (movieModel.actor1.length) {
    self.actorLabel.text = [NSString stringWithFormat:@"演员：%@、%@",movieModel.actor1,movieModel.actor2];
    }else{
        self.actorLabel.text=  @"";
    }
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString: movieModel.image ]placeholderImage:[UIImage imageNamed:@"empty"]];
    self.coverImageView.clipsToBounds = YES;
    [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    
}

- (IBAction)buyBtnClick:(id)sender {
}


- (IBAction)foreBtnClick:(id)sender {
}


//设置按钮边框登等
- (void)processButton:(UIButton*)button{
    button.layer.borderColor = myPink.CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius  = 12;
}

@end

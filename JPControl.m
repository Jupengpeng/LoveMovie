//
//  JPControl.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-17.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "JPControl.h"
@implementation JPControl

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame url:(NSString *)url
{

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"empty"]];
    return imageView;
    
}


+ (UIButton *)createButtonWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width titleColor:(UIColor *)titleColor adjustWidth:(BOOL)isAdjust textAligment:(NSTextAlignment )NSTextAlignment target:(id)target action:(SEL)action {
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    button.layer.borderColor = borderColor.CGColor;
    button.layer.borderWidth = width;
    [button.titleLabel setTextColor:titleColor];
    button.titleLabel.adjustsFontSizeToFitWidth =isAdjust;
    button.titleLabel.textAlignment = NSTextAlignment;
    [ button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.numberOfLines =2;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.highlighted = NO;
    return button;
}



    
    

@end

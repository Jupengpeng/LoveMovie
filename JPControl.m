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

+ (NSString *)transformDateWithNumeber:(int)oriSeconds{
    int seconds = oriSeconds - (8*60-16)*60 ;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString * str=  [dateFormatter stringFromDate:date];
    
    return str;
}

+ (NSString *)transformToHourWithMinutes:(int)minutes{
    int h = 0;
    int m = 0;
    NSString * time = nil;
    h = minutes/60;
    m = minutes%60;
    if (h<0) {
        h=-h;
    }
    if (h>24) {
        h=h%24;
    }
    time = [NSString stringWithFormat:@"%02d:%02d",h,m];
    return time;
}

    
    

@end

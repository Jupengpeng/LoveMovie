//
//  JPControl.h
//  LoveMovie
//
//  Created by qianfeng on 15-7-17.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import <UIKit/UIKit.h>

@interface JPControl : NSObject
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame url:(NSString *)url;

+ (UIButton *)createButtonWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width titleColor:(UIColor *)titleColor adjustWidth:(BOOL)isAdjust textAligment:(NSTextAlignment )NSTextAlignment target:(id)target action:(SEL)action ;

@end

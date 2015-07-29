//
//  MyMovieDetailController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "MyMovieDetailController.h"

@interface MyMovieDetailController ()
{
    AFHTTPRequestOperationManager * _manager;
}
@end

@implementation MyMovieDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    
//    设置请求序列 添加请求头
//    _manager.requestSerializer setValue:<#(NSString *)#> forHTTPHeaderField:@"X-Mtime-Mobile-CheckValue"
//        [manager.requestSerializer setValue:@"236492" forHTTPHeaderField:@"app"];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    //设置导航栏按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithTitle:@"购票" style:UIBarButtonItemStyleBordered target:self action:@selector(pop:)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
//    [self initUI];
    [self initData];
}

- (void)pop:(UIBarButtonItem *)item{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)initUI{
//    UIButton * button  = [UIButton alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    
//    
//}
//
- (void)initData{
    NSString * url  = [NSString stringWithFormat:kMyMovieDetailUrl,self.locationId,self.movieId];
    BBLog(@"电影详情url%@",url);
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            BBLog(@"下载成功");
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

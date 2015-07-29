//
//  TopListViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/28.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "TopListViewController.h"

@interface TopListViewController ()

@end

@implementation TopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//
//    [_manager GET:kTicketOfficeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (responseObject) {
//            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSArray * topList = dict[@"topList"];
//            NSDictionary * globalDict = topList[1];
//            NSArray * globalArr = globalDict[@"subTopList"];
//            
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        BBLog(@"下载失败了");
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

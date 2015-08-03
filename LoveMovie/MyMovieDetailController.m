//
//  MyMovieDetailController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/27.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "MyMovieDetailController.h"

@interface MyMovieDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@end

@implementation MyMovieDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];


    //设置导航栏按钮
    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop:) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self initUI];
    [self initData];
}

- (void)pop:(UIBarButtonItem *)item{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)initUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    
    
    
}


- (void)initData{
    NSString * url  = [NSString stringWithFormat:kMyMovieDetailUrl,self.locationId,self.movieId];
    BBLog(@"电影详情url%@",url);
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {

            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell  = [[UITableViewCell alloc]init];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

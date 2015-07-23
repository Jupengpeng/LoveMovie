//
//  BuyCinemaViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-20.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyCinemaViewController.h"

@interface BuyCinemaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@end

@implementation BuyCinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allCinemaUrl = [NSString stringWithFormat:kAllCinemaUrl,kZZLid];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMyArray];
    [self initData];
    [self initUI];
}



- (void)initData{

    
    
    __weak typeof(self) weakSelf = self;
    [_manager GET:self.allCinemaUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            BuyCinemaModel * cinemaModel =  [[BuyCinemaModel alloc]init];
            [cinemaModel setValuesForKeysWithDictionary:dict];
            for (NSDictionary * dict in cinemaModel.cinemas) {
                CinemaModel * myModel = [[CinemaModel alloc]init];
                [myModel setValuesForKeysWithDictionary:dict];
                [weakSelf.cinemasArr addObject:myModel];
            }
            
            [weakSelf.tableView reloadData];
            ;
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
}

- (void)initUI{

    
    
    //添加button
    NSArray * titles = @[@"全部",@"附近",@"价格",@"筛选"];
    for (int i = 0; i < 4; i ++) {
        UIButton * button = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width/4*i, 64, kScreenSize.width/4, 30) borderColor:[UIColor lightGrayColor] borderWidth:1.0f titleColor:[UIColor blackColor] adjustWidth:NO textAligment:NSTextAlignmentCenter target:self action:@selector(btnClick:)];
        [button setTitle:titles[i] forState:UIControlStateNormal] ;
        //默认第一个点着
        if (i==0) {
            button.selected =YES;
        }
        [button setTitleColor:myRed forState:UIControlStateSelected];
        button.tag = 201+i;
        [self.view addSubview:button];
        
    }
//
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, kScreenSize.width, kScreenSize.height-94-49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}



- (void)btnClick:(UIButton *)button{
    button.selected = YES;
    //如果不是当前事件取消点击效果
    NSInteger myTag = button.tag;
    for (NSInteger i = 201; i < 205; i ++) {
        UIButton * myButton = (UIButton *)[self.view viewWithTag:i];
        if (i!=myTag) {
            myButton.selected= NO;
        }
    }
    //如果当前按钮已被点击，直接跳过方法
    if (self.currentTag==button.tag) {
        return;
    }
    switch (button.tag) {
        case 201:
        {
            self.currentTag = button.tag;
            [self initData];
            
            
            
            
            [self.tableView reloadData];
        }
            break;
        case 202:
        {
            self.currentTag = button.tag;

            
            [self.tableView reloadData];

        }
            break;
        case 203:
        {
            self.currentTag = button.tag;

            
            [self.tableView reloadData];

        }
            break;
        case 204:
        {
            self.currentTag = button.tag;

            
            [self.tableView reloadData];

        }
            break;
            
            
        default:
            break;
    }
    
    
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.cinemasArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell  = [[UITableViewCell alloc]init];
    return cell;
    
}

//各种初始化
- (void)initMyArray{
    if (self.cinemasArr ==nil) {
        self.cinemasArr = [[NSMutableArray alloc]init];
    }
    
    if (!self.businessAreasArr) {
        self.businessAreasArr = [[NSMutableArray alloc]init];
    }
    if (!self.districtsArr) {
        self.districtsArr = [[NSMutableArray alloc]init];
    }
    if (!self.subwaysArr) {
        self.subwaysArr = [[NSMutableArray alloc]init];
    }
    if (!self.subwayCinemasArr) {
        self.subwayCinemasArr = [[NSMutableArray alloc]init];
    }
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}



@end

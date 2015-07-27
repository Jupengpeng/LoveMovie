//
//  BuyCinemaViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-20.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyCinemaViewController.h"
#define kBuyCinemaCellId @"BuyCinemaCell"
@interface BuyCinemaViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@end

@implementation BuyCinemaViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMyArray];
    [self initData];
    [self initUI];
}



- (void)initData{

    self.allCinemaUrl = [NSString stringWithFormat:kAllCinemaUrl,self.currentCityId];

    
    __weak typeof(self) weakSelf = self;
    [_manager GET:self.allCinemaUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSArray * array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            for (NSDictionary * dict in array) {
                CinemaModel * cinemaModel = [[CinemaModel alloc]init];
                [cinemaModel setValuesForKeysWithDictionary:dict];
                cinemaModel.distance = [self getDistanceFrom:self.myCoordinate toDistWithLatitude:cinemaModel.latitude Longitude:cinemaModel.longitude];
                [self.cinemasArr addObject:cinemaModel];
            }

            
            [weakSelf.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
}

- (void)initUI{

    
    
    //添加button
    NSArray * titles = @[@"全部",@"附近",@"价格"];
    for (int i = 0; i < 3; i ++) {
        UIButton * button = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width/3*i, 64, kScreenSize.width/3, 30) borderColor:[UIColor lightGrayColor] borderWidth:1.0f titleColor:[UIColor blackColor] adjustWidth:NO textAligment:NSTextAlignmentCenter target:self action:@selector(MySortClick:)];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyCinemaCell" bundle:nil] forCellReuseIdentifier:kBuyCinemaCellId];
}


//四个按钮的点击事件
- (void)MySortClick:(UIButton *)button{
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
    
#warning  如果数组为空 不允许点击 防止点击过快数组为空
    if (!self.cinemasArr) {

    }

    switch (button.tag) {
        case 201:
        {
            self.currentTag = button.tag;
            if (self.cinemasArr) {
                [self.cinemasArr removeAllObjects];
            }
            [self initData];
            [self.tableView reloadData];
        }
            break;
        case 202:
        {
            self.currentTag = button.tag;
        
            //按照distance为model排序
            for (NSInteger i= 0 ; i < self.cinemasArr.count-1; i ++) {
                for (NSInteger j = 0; j < self.cinemasArr.count-1-i; j ++) {
                    CinemaModel * model1 = [self.cinemasArr objectAtIndex:j];
                    CinemaModel * model2 = [self.cinemasArr objectAtIndex:j+1];
                    if (model1.distance>model2.distance) {
                        [self exchangeArray:self.cinemasArr WithIndex1:j index2:j+1];
                    }
                }
            }

            
            [self.tableView reloadData];

        }
            break;
        case 203:
        {
            self.currentTag = button.tag;
            //去除价格为空的
            for (CinemaModel * model in self.cinemasArr) {
                if (!model.minPrice) {
                    [self.emptyPriArr addObject:model];
                }
            }
            [self.cinemasArr removeObjectsInArray:self.emptyPriArr];
            
            for (NSInteger i= 0 ; i < self.cinemasArr.count-1; i ++) {
                for (NSInteger j = 0; j < self.cinemasArr.count-1-i; j ++) {
                    CinemaModel * model1 = [self.cinemasArr objectAtIndex:j];
                    CinemaModel * model2 = [self.cinemasArr objectAtIndex:j+1];
                    if (model1.minPrice>model2.minPrice) {
                        [self exchangeArray:self.cinemasArr WithIndex1:j index2:j+1];
                    }
                }
            }
            //加上控价格到最后
            [self.cinemasArr addObjectsFromArray:self.emptyPriArr];
            
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyCinemaCell * cell = [tableView dequeueReusableCellWithIdentifier:kBuyCinemaCellId forIndexPath:indexPath];
    CinemaModel * cinemaModel = self.cinemasArr[indexPath.row];
    cell.distance = cinemaModel.distance;
    cell.myCoordinate =self.myCoordinate;
    [cell showCinemaDataWithModel:cinemaModel];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CinemaModel * cinemaModel = self.cinemasArr[indexPath.row];
    CinemaDetailController * cVC = [[CinemaDetailController alloc]init];
    cVC.cinemaId = cinemaModel.cinemaId;
    [self.navigationController pushViewController:cVC animated:YES];
    
}




//各种初始化
- (void)initMyArray{
    if (self.cinemasArr ==nil) {
        self.cinemasArr = [[NSMutableArray alloc]init];
    }
    
    if (!self.distanceArr) {
        self.distanceArr = [[NSMutableArray alloc]init];
    }
    if (!self.districtsArr) {
        self.districtsArr = [[NSMutableArray alloc]init];
    }
    if (!self.emptyPriArr) {
        self.emptyPriArr = [[NSMutableArray alloc]init];
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

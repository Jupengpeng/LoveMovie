//
//  FirstPageViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-14.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HomePageViewController.h"
#import "AFNetworking.h"
#import "HomeHotPointModel.h"
#import "areaSecondCell.h"
#import "HomeAreaSecondModel.h"
#import "HomeHotPointCell.h"
#import "HomeHotType1Cell.h"
#import "HomeHotType2Cell.h"
#import "HomeHotPointType3.h"
#import "HomeHotPointModel.h"
#import "HomeHotMovieCell.h"
#import "HomeHotMovieModel.h"
#import "HomeMovieModel.h"
#import "HomeScrollCell.h"
#import "HomeAdvModel.h"
#import "HomeHeaderModel.h"
#import "HomeHeaderView.h"
#define kareaSecondCellId @"areaSecondCell"
#define kHotpointButtonCellId @"HomeHotPointCell"
#define kHomeHotType1CellId @"HomeHotType1Cell"
#define kHomeHotType2CellId @"HomeHotType2Cell"
#define kHomeHotPointType3Id @"HomeHotPointType3"
#define kHomeHotMovieCellId @"HomeHotMovieCell"
#define kHomeScrollCellId @"HomeScrollCell"
#define kHomeHeaderViewId @"HomeHeaderView"
@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) HomePageModel * homePageModel;
@property (nonatomic,strong) HomeHeaderModel * headerModel;



@end

@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self initData];

    [self initUI];
    
}
- (void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"areaSecondCell" bundle:nil]   forCellReuseIdentifier:kareaSecondCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotPointCell" bundle:nil] forCellReuseIdentifier:kHotpointButtonCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotType1Cell" bundle:nil] forCellReuseIdentifier:kHomeHotType1CellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotType2Cell" bundle:nil] forCellReuseIdentifier:kHomeHotType2CellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotPointType3" bundle:nil] forCellReuseIdentifier:kHomeHotPointType3Id];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHotMovieCell" bundle:nil] forCellReuseIdentifier:kHomeHotMovieCellId];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeScrollCell" bundle:nil] forCellReuseIdentifier:kHomeScrollCellId];
    [self.tableView registerClass:[HomeHeaderView class] forCellReuseIdentifier:kHomeHeaderViewId];
    
}
- (void)initData{
    NSString * headerUrl = [NSString stringWithFormat:kHomeHeaderUrl,kZZLid];
    
    __weak typeof(self) weakSelf = self;
    [_manager GET:headerUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            weakSelf.headerModel = [[HomeHeaderModel alloc]init];
            [weakSelf.headerModel setValuesForKeysWithDictionary:dict];
            
        }
        
        
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"下载失败%@",error );
    }];
    
    
    [_manager GET:kHomePageUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            weakSelf.homePageModel = [[HomePageModel alloc]initWithDictionary:dict error:nil];
            [weakSelf.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败%@",[error description]);
    }];
    
    

    
    
}



#pragma mark - <UITableViewDataSource,UITableViewDelegate>



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            return kHomeImageViewHeight-14;
        }
        case 1:
        {
            return 530;
        }
        case 2:
        {
            return 98;
        }
            //
        case 3:
        {
            return 49;
        }
            //两种cell根据type判断
        case 4:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[0];
            if (model.type==1) {
                return 160;
            }else{
                return 120;
            }
        }
        case 5:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[1];
            if (model.type==1) {
                return 160;
            }else{
                return 120;
            }
        }
            break;
        case 6:
        {
            HomeHotPointModel * model = self.homePageModel.hotPoints[2];
            if (model.type==1) {
                return 160;
            }else{
                return 120;
            }
        }
            break;
        case 7:
        {
            return 49;
        }
            break;
        case 8:
        {
            return 315;
        }
            break;
            
        default:
            break;
    }
    return 530;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[[UITableViewCell alloc]init];
    switch (indexPath.row) {
        case 0:{
            HomeHeaderView * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHeaderViewId forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell showHomeHeaderCellDataWithHeaderModel:self.headerModel];
            return cell;
            
            
        }
        case 1:{
            areaSecondCell * cell  = [tableView dequeueReusableCellWithIdentifier:kareaSecondCellId forIndexPath:indexPath];
            HomeAreaSecondModel * areaSecondModel = self.homePageModel.areaSecond;
            [cell showDataWithAreaSecondModel:areaSecondModel];
            return cell;
        }
        case 2:{
            HomeScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeScrollCellId forIndexPath:indexPath];
            [cell showDataWithAdvModel:self.homePageModel];
            return cell;
        }
        case 3:{
            HomeHotPointCell * cell = [tableView dequeueReusableCellWithIdentifier:kHotpointButtonCellId forIndexPath:indexPath];
            
            return cell;
        }
        case 4:{
            //4 5 6 cell判断type来决定cell的类型
            HomeHotPointModel * model = self.homePageModel.hotPoints[0];
            if (model.type==1) {
                HomeHotType1Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType1CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                
                return cell;
                
            }else{
                HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                return cell;
                
            }
            
        }
        case 5:{
            HomeHotPointModel * model = self.homePageModel.hotPoints[1];
            if (model.type==1) {
                HomeHotType1Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType1CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                
                return cell;
                
            }else{
                HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                return cell;
                
            }        }
        case 6:{
            HomeHotPointModel * model = self.homePageModel.hotPoints[2];
            if (model.type==1) {
                HomeHotType1Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType1CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                
                
                
                return cell;
                
            }else{
                HomeHotType2Cell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotType2CellId forIndexPath:indexPath];
                [cell showDataWithHomeHotPointModel:model];
                return cell;
                
            }        }
        case 7:{
            HomeHotPointType3 * cell = [tableView  dequeueReusableCellWithIdentifier:kHomeHotPointType3Id forIndexPath:indexPath];
            
            return cell;
        }
        case 8:{
            HomeHotMovieCell * cell = [tableView dequeueReusableCellWithIdentifier:kHomeHotMovieCellId forIndexPath:indexPath];
            [cell showDataWithHomeHotMovieModel:self.homePageModel.hotMovie];
            return cell;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}







@end

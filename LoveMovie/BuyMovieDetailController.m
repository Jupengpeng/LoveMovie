//
//  BuyMovieDetailController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/26.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "BuyMovieDetailController.h"
#define kHotCinemaButton 601
#define kBuyCinemaCellId @"BuyCinemaCell"
@interface BuyMovieDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}

@property (nonatomic,strong) NSMutableArray * timeArr;

@property (nonatomic,strong) NSMutableArray * cinemaArr;


@end

@implementation BuyMovieDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor whiteColor];
    //设置导航栏按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithTitle:@"购票" style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    [self addTitleViewWithTitle:self.movieName];
    [self initMany];
    [self initUI];
    [self initTime];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)firstDownoadData{
    TimeModel * timeModel = self.timeArr[0];
    NSString * date= [self firstTransformTimeWithStr:timeModel.dateValue];
    [self downloadDataWithDateStr:date];
    
    
}

- (void)initMany{
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (self.timeArr==nil) {
        self.timeArr = [[NSMutableArray alloc]init];
    }
    if (!self.cinemaArr) {
        self.cinemaArr = [[NSMutableArray alloc]init];
    }
    if (!self.emptyPriArr) {
        self.emptyPriArr = [[NSMutableArray alloc]init];
    }
}

- (void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70,kScreenSize.width , kScreenSize.height-70) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyCinemaCell" bundle:nil] forCellReuseIdentifier:kBuyCinemaCellId];
}
//初始化时间和时间按按钮
- (void)initTime{
    NSString * timeUrl = [NSString stringWithFormat:kHotTimeUrl,self.locationId,self.movieId];
    [_manager GET:timeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray * times = dict[@"showtimeDates"];
            for (NSDictionary * dict in times) {
                TimeModel * timeModel = [[TimeModel alloc]init];
                [timeModel setValuesForKeysWithDictionary:dict];
                [self.timeArr addObject:timeModel];
            }
            
        }
        //time数组加载完毕
        [self showTimeButtons];
        [self firstDownoadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];

    
}

- (void)showTimeButtons{
    CGFloat w = kScreenSize.width/self.timeArr.count;
    NSArray * dayArr = @[@"今天",@"明天",@"后天",@"大后天"];
    for (NSInteger i = 0; i < self.timeArr.count; i ++) {
        TimeModel * timeModel = self.timeArr[i];
        //处理日期格式
        NSString * date = [self secondTransformTimeWithStr:timeModel.dateValue];
        
        UIButton * timeButton = [[UIButton alloc]initWithFrame:CGRectMake(w*i, 64, w, 40)];
        [timeButton setTitle:[NSString stringWithFormat:@"%@(%@)",dayArr[i],date] forState:UIControlStateNormal];
        timeButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        timeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [timeButton setTitleColor:myRed forState:UIControlStateSelected];
        timeButton.tag = kHotCinemaButton+i;
        timeButton.backgroundColor = [UIColor whiteColor];
        [timeButton addTarget:self action:@selector(timeCinema:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            timeButton.selected = YES;
        }
        [self.view addSubview:timeButton];
    }
    
    
    //添加button
    NSArray * titles = @[@"全部",@"附近",@"价格"];
    for (int i = 0; i < 3; i ++) {
        UIButton * button = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width/3*i, 104, kScreenSize.width/3, 30) borderColor:[UIColor lightGrayColor] borderWidth:0.2f titleColor:[UIColor blackColor] adjustWidth:NO textAligment:NSTextAlignmentCenter target:self action:@selector(sortClick:)];
        button.backgroundColor = myLight;
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitle:titles[i] forState:UIControlStateNormal] ;
        //默认第一个点着
        if (i==0) {
            button.selected =YES;
        }
        [button setTitleColor:myRed forState:UIControlStateSelected];
        button.tag = 701+i;
        [self.view addSubview:button];
    }
    
}
//排序选择

- (void)sortClick:(UIButton *)button{
    
    
    int myTag = button.tag;
    for (int i = 0; i< 3; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i+701];
        if (button.tag!=myTag) {
            button.selected = NO;
        }
    }
    //如果已被点击直接跳过否则设为被点击
    if (button.selected) {
        return;
    }
    button.selected = YES;
    
    
    
    switch (button.tag) {
        case 701:
        {
            if (self.cinemaArr) {
                [self.cinemaArr removeAllObjects];
            }
            [self firstDownoadData];
            [self.tableView reloadData];
        }
            break;
        case 702:
        {
            
            //按照distance为model排序
            for (NSInteger i= 0 ; i < self.cinemaArr.count-1; i ++) {
                for (NSInteger j = 0; j < self.cinemaArr.count-1-i; j ++) {
                    CinemaModel * model1 = [self.cinemaArr objectAtIndex:j];
                    CinemaModel * model2 = [self.cinemaArr objectAtIndex:j+1];
                    if (model1.distance>model2.distance) {
                        [self exchangeArray:self.cinemaArr WithIndex1:j index2:j+1];
                    }
                }
            }
            
            
            [self.tableView reloadData];
            
        }
            break;
        case 703:
        {
            //去除价格为空的
            for (CinemaModel * model in self.cinemaArr) {
                if (!model.minPrice) {
                    [self.emptyPriArr addObject:model];
                }
            }
            [self.cinemaArr removeObjectsInArray:self.emptyPriArr];
            
            for (NSInteger i= 0 ; i < self.cinemaArr.count-1; i ++) {
                for (NSInteger j = 0; j < self.cinemaArr.count-1-i; j ++) {
                    CinemaModel * model1 = [self.cinemaArr objectAtIndex:j];
                    CinemaModel * model2 = [self.cinemaArr objectAtIndex:j+1];
                    if (model1.minPrice>model2.minPrice) {
                        [self exchangeArray:self.cinemaArr WithIndex1:j index2:j+1];
                    }
                }
            }
            //加上控价格到最后
            [self.cinemaArr addObjectsFromArray:self.emptyPriArr];
            
            [self.tableView reloadData];
            
        }
            break;
        default:
            break;
    }
    
    
    

    
}

//选择哪天的电影院们
- (void)timeCinema:(UIButton *)button{
    
    //如果已被点击直接跳过否则设为被点击
    if (button.selected) {
        return;
    }
    
    int myTag = button.tag;
    for (int i = 0; i<self.timeArr.count; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i+kHotCinemaButton];
        if (button.tag!=myTag) {
            button.selected = NO;
        }
    }

    button.selected = YES;
    
    TimeModel * timeModel = self.timeArr[button.tag-kHotCinemaButton];
    NSString * date= [self firstTransformTimeWithStr:timeModel.dateValue];
    [self downloadDataWithDateStr:date];
    [self.tableView reloadData];
    
    
    int changeTag = 701;
    for (int i = 0; i< 3; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i+701];
        if (button.tag!=changeTag) {
            button.selected = NO;
        }else{
            button.selected = YES;
        }
    }
}

//根据日期下载数据
- (void)downloadDataWithDateStr:(NSString *)date{
    if (self.cinemaArr) {
        [self.cinemaArr removeAllObjects];
    }
    NSString * url =  [NSString stringWithFormat:kHotTimeCinemas,date,self.locationId,self.movieId];
//    BBLog(@"%@",url);
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray *  csArray = dict[@"cs"];
            for (NSDictionary * dict in csArray) {
                CinemaModel * cinemaModel =  [[CinemaModel alloc]init];
                [cinemaModel setValuesForKeysWithDictionary:dict];
                cinemaModel.distance = [self getDistanceFrom:self.myCoordinate toDistWithLatitude:cinemaModel.latitude Longitude:cinemaModel.longitude];

                [self.cinemaArr addObject:cinemaModel];
            }
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
}


#pragma mark-<UITableViewDataSource,UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cinemaArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyCinemaCell * cell = [tableView dequeueReusableCellWithIdentifier:kBuyCinemaCellId forIndexPath:indexPath];
    cell.myCoordinate = self.myCoordinate;
    CinemaModel * cinemaModel = self.cinemaArr[indexPath.row];
    __weak typeof(self) weakSelf = self;
    [cell setMyBlock:^{
        //跳出影院的场次视图
        HotMovieCinemaController * hVC = [[HotMovieCinemaController alloc]init];
        hVC.cinemaName = cinemaModel.cn;
        hVC.cinemaId = cinemaModel.cid;
        hVC.movieId = weakSelf.movieId;
        hVC.view.frame = CGRectMake(0, 77, kScreenSize.width, kScreenSize.height-77);
        [weakSelf.view addSubview:hVC.view];
        [weakSelf addChildViewController:hVC];
        
    }];
    [cell showCSDataWithModel:cinemaModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CinemaModel * model = self.cinemaArr[indexPath.row];
    CinemaDetailController * cVC = [[CinemaDetailController alloc]init];;
    cVC.cinemaId = model.cid;
    [self.navigationController pushViewController:cVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

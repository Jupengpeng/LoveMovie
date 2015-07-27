//
//  CinemaOfMovController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/25.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "CinemaOfMovController.h"

@interface CinemaOfMovController ()<UIScrollViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic,strong) NSMutableArray * seatsArr;
@property (nonatomic,strong) UIView * myView;
@end

@implementation CinemaOfMovController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化
    if (self.seatsArr==nil) {
        self.seatsArr = [[NSMutableArray alloc]init];
    }
    //初始化
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置导航栏按钮
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;

    [self initUI];
    [self initData];
}

- (void)initData{
    NSString * url  = [NSString stringWithFormat:kSeatsUrl,self.myDId ];
    
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            InCinemaModel * cinemaModel =  [[InCinemaModel alloc]init];
            [cinemaModel setValuesForKeysWithDictionary:dict];
            for (NSDictionary * dict in cinemaModel.seat) {
                seatModel * model  =  [[seatModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.seatsArr addObject:model];
            }
            [self showWholeCinemaWithInCinemaModel:cinemaModel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
}

- (void)showWholeCinemaWithInCinemaModel:(InCinemaModel *)model{
    _myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, self.scrollView.frame.size.height)];
    _myView.layer.borderWidth = 0.2f;
    //总宽度减去间隔宽度*个数
    CGFloat w = (kScreenSize.width-2*(model.seatColumnCount+1))/model.seatColumnCount;
    CGFloat h = w*8/9.0;
    for (NSInteger i = 0 ; i < self.seatsArr.count; i ++) {
        seatModel * model = self.seatsArr[i];
        if ([model.name isEqualToString: @""]) {
            continue;
        }
        UIButton * seatButton = [[UIButton alloc]initWithFrame:CGRectMake(2+(2+ w)*model.x , 2+(2+h)*model.y, w, h)];
        if (model.status) {

        [seatButton setBackgroundImage:[UIImage imageNamed:kSeatUnselected] forState:UIControlStateNormal];
            [seatButton setBackgroundImage:[UIImage imageNamed:kSeatSelected] forState:UIControlStateSelected];
        }else{
            [seatButton setBackgroundImage:[UIImage imageNamed:kSeatCantSelected] forState:UIControlStateNormal];
            seatButton.enabled = NO;
        }
        seatButton.tag = 401+i;
        [seatButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_myView addSubview:seatButton];
    }
    self.scrollView.delegate = self;
    self.scrollView.contentSize = _myView.frame.size;
    [self.scrollView addSubview:_myView];
    //各种显示
    self.hallLabel.text = [NSString stringWithFormat:@"%@ 银幕" ,model.hallName];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@ %@/%@",model.movieName,model.versionDesc,model.language]];
    self.cinemaLabel.text = model.cinemaName;
    self.leftSeatsLabel.text = [NSString stringWithFormat:@"票价:%d" ,model.salePrice/100];
    
    
}
- (void)btnClick:(UIButton *)button{
    //如果不是当前事件取消点击效果
    NSInteger myTag = button.tag;
    for (NSInteger i = 401; i < 401+self.seatsArr.count; i ++) {
        UIButton * myButton = (UIButton *)[self.view viewWithTag:i];
        if (i!=myTag) {
            myButton.selected= NO;
        }
    }
    int loc = button.tag - 401;
    button.selected = YES;
    seatModel * model = self.seatsArr[loc];
    self.currentSeat.text =[NSString stringWithFormat:@"被选座位:%@" ,model.name];
    
    
}

- (void)initUI{
    self.hallLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, kScreenSize.width, 60)];
    self.hallLabel.text = @"5号厅 银幕";
    self.hallLabel.font = [UIFont systemFontOfSize:13.0];
    self.hallLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.hallLabel];
    UIImageView  * screeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, kScreenSize.width-20, 30)];
    screeImageView.image = [UIImage imageNamed:@"v10_screen"];
    [self.view addSubview:screeImageView];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hallLabel.frame), kScreenSize.width, 160)];
    self.scrollView.zoomScale = 1.0;
    self.scrollView.minimumZoomScale = 1.0;   //最小倍数
    self.scrollView.maximumZoomScale = 2.0;  //最大倍数
    [self.view addSubview:self.scrollView];
    //座位
    self.currentSeat = [[UILabel alloc]initWithFrame:CGRectMake(10,10+CGRectGetMaxY(self.scrollView.frame), kScreenSize.width-20, 20)];
    self.currentSeat.backgroundColor =myGray;
    self.currentSeat.text = @"被选座位:    ";
    self.currentSeat.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.currentSeat];
    //影院
    self.cinemaLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20+CGRectGetMaxY(self.currentSeat.frame), kScreenSize.width-20, 20)];
    self.cinemaLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:self.cinemaLabel];
    
    //剩余座位
    self.leftSeatsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5+CGRectGetMaxY(self.cinemaLabel.frame), kScreenSize.width-20, 20)];
    self.leftSeatsLabel.font = [UIFont systemFontOfSize:17.0];
    self.leftSeatsLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:self.leftSeatsLabel];
    
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _myView;
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

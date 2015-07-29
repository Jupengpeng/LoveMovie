//
//  HotMovieCinemaController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/26.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "HotMovieCinemaController.h"
#define kButtonTag 801
#define kCinemaDetailCellId @"CinemaDetailCell"
@interface HotMovieCinemaController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic,strong) NSMutableArray * timeArr;
@property (nonatomic,strong) NSMutableArray * playArr;
@property (nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation HotMovieCinemaController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = myLight;
    self.view.userInteractionEnabled = YES;
    [self initMany];

    
    [self initUI];
    
    [self initData];
    
}

- (void)initMany{
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (!self.timeArr) {
        self.timeArr = [[NSMutableArray alloc]init];
    }

    if (!self.playArr) {
        self.playArr = [[NSMutableArray alloc]init];
    }
    if (!self.dataArr) {
        self.dataArr  = [[NSMutableArray alloc]init];
    }
}
- (void)initUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, kScreenSize.width, kScreenSize.height-77-100) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CinemaDetailCell" bundle:nil] forCellReuseIdentifier:kCinemaDetailCellId];
    
    UILabel * cinemaLabel =  [[UILabel alloc]initWithFrame:CGRectMake(40, 0, kScreenSize.width-80, 60)];
    cinemaLabel.textAlignment = NSTextAlignmentCenter;
    cinemaLabel.text = self.cinemaName;
    [self.view addSubview:cinemaLabel];
    
    UIButton * dismissButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenSize.width-50, 10, 40, 40)];
    [dismissButton setBackgroundImage:[UIImage imageNamed:@"icon_clear"] forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(romove:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
}

- (void)romove:(UIButton *)button{

    [self.view removeFromSuperview];
    [self removeFromParentViewController];

}


- (void)initData
{
    NSArray * dayArr = @[@"今天",@"明天",@"后天",@"大后天"];
    NSString * url  = [NSString stringWithFormat:kHotTimeCinemaDetail,self.cinemaId,self.movieId];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSArray * arr = [NSArray arrayWithArray:dict[@"showDates"]];
            
            for (int i = 0; i < arr.count; i ++ )  {
                //添加改变形式后的日期字符串
                [self.timeArr addObject:[NSString stringWithFormat:@"%@(%@)",dayArr[i], [self secondTransformTimeWithStr:arr[i] ] ] ];
            }
            NSArray * showtArr= [NSArray arrayWithArray: dict[@"dateShowtimes"]];
            for (NSDictionary * showDict in showtArr) {
                //创建存取当前日期 一组上映时间的数据
                NSMutableArray * playsArr = [[NSMutableArray alloc]init];
                //取得showTimes字典数组
                NSArray * showTimesArr = [NSArray arrayWithArray:showDict[@"showtimes"]];
                //去的上映的每字典
                for (NSDictionary * onePlay in showTimesArr) {
                    SofCinemaModel * sModel  = [[SofCinemaModel alloc]init];
                    [sModel setValuesForKeysWithDictionary:onePlay];
                    if (sModel.startTime!=sModel.endTime) {
                        [playsArr addObject:sModel];
                    }
                }
                //该组上映添加完毕 该数组加到总数组里
                [self.playArr addObject:playsArr];
            }
            //日期按钮buton开始构建
            [self initButton];
            //显示界面
            [self initFirstShow];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
}



- (void)initButton{
    
    
    CGFloat w = kScreenSize.width/self.timeArr.count;
    for (int i = 0;i < self.timeArr.count ; i ++ ) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(w*i, 60, w, 40)];
        [button setTitle:self.timeArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:myRed forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 0.3;
        
        button.tag = kButtonTag+i ;
        [button addTarget:self action:@selector(chooseArr:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            button.selected = YES;
        }
        [self.view addSubview:button];
    }
}

- (void)chooseArr:(UIButton *)button{
    //如果已被点击直接跳过否则设为被点击
    if (button.selected) {
        return;
    }
    
    
    long myTag = button.tag;
    for (int i = 0; i<self.timeArr.count; i++) {
        UIButton * button = (UIButton *)[self.view viewWithTag:i+kButtonTag];
        if (button.tag!=myTag) {
            button.selected = NO;
        }
    }

    button.selected = YES;

    long date  = button.tag - kButtonTag;
    if (self.dataArr) {
        [self.dataArr removeAllObjects];
    }
    [self.dataArr addObjectsFromArray:self.playArr[date]];
    [self.tableView reloadData];
}

- (void)initFirstShow{
    if (self.dataArr) {
        [self.dataArr removeAllObjects];
    }
    [self.dataArr addObjectsFromArray:self.playArr[0]];
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CinemaDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:kCinemaDetailCellId forIndexPath:indexPath];
    SofCinemaModel * model = self.dataArr[indexPath.row];
    cell.niv = self.navigationController;

    [cell showDataWithSModel:model];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end

//
//  CinemaDetailController.m
//  LoveMovie
//
//  Created by qianfeng on 15-7-24.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "CinemaDetailController.h"
#define kCinemaDetailCellId @"CinemaDetailCell"
@interface CinemaDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * headerArr;
#define kBtnTag 300
@end

@implementation CinemaDetailController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (!self.dataArr) {
        self.dataArr = [[NSMutableArray alloc]init];
    }
    if (!self.headerArr) {
        self.headerArr = [[NSMutableArray alloc]init];
    }
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithTitle:@"购票" style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    [self downLoadHeaderData];
    [self initUI];
    
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
//下载头视图数据
- (void)downLoadHeaderData{
    
    //头视图部分的数据下载
    NSString * headerUrl = [NSString stringWithFormat:kCinemaDetHeaderUrl,self.cinemaId];
    __weak typeof(self) weakSelf = self;
    [_manager GET:headerUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            weakSelf.headerModel =  [[CInemaHeaderModel alloc]init];
            [weakSelf.headerModel setValuesForKeysWithDictionary:dict];
            [weakSelf showHeaderWithModel:weakSelf.headerModel];
        }
        
        MovieInHeaderModel * firstMovie = [[MovieInHeaderModel alloc]init];
        [firstMovie setValuesForKeysWithDictionary:weakSelf.headerModel.movies[0]];
        weakSelf.currentDate = firstMovie.showDates[0];
        
        [weakSelf downloadDisplayTimeDataWithMovieId:firstMovie.movieId];
        
        
        
        [weakSelf.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    


    
}
//根据当前电影下载当前影院的上映数据
- (void)downloadDisplayTimeDataWithMovieId:(int )movieId{
    NSString * url = [NSString stringWithFormat:kCinemaDetailUrl,self.cinemaId,self.currentDate,movieId];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.dataArr) {
            [self.dataArr removeAllObjects];
        }
        
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            CinemaDetailModel * detailModel = [[CinemaDetailModel alloc]init];
            [detailModel setValuesForKeysWithDictionary:dict];
            for (NSDictionary * dict in detailModel.s) {
                SofCinemaModel * sModel = [[SofCinemaModel alloc]init];
                [sModel setValuesForKeysWithDictionary:dict];
                if (sModel.startTime!=sModel.endTime) {
                    //自己感觉的算法，无奈得不到服务器具体算法
                    sModel.spaceTime = (sModel.endTime - sModel.startTime - 30028)/60;
                    BBLog(@"%d",sModel.spaceTime);
                    [sModel setValuesForKeysWithDictionary:dict];

                    [self.dataArr addObject:sModel];
                }

            }
            
        }
        if (self.dataArr.count==0) {
            self.dateLabel.text = @"抱歉，暂无信息";
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];

    
}

- (void)showHeaderWithModel:(CInemaHeaderModel *)headerModel{
    CGFloat w = 125;
    CGFloat space = (kScreenSize.width-125)/2;
    
    UIView * headerView=  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 340)];
    
    
    CinemaInHeaderModel * cinemaModel = [[CinemaInHeaderModel alloc]init];
    [cinemaModel setValuesForKeysWithDictionary:headerModel.cinema];
    for (NSDictionary * dict in headerModel.movies) {
        MovieInHeaderModel * movieModel  = [[MovieInHeaderModel alloc]init];
        [movieModel setValuesForKeysWithDictionary:dict];
        [self.headerArr addObject:movieModel];
    }
    
    UIButton * cinemaButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 80)];
    //影院名字
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenSize.width, 20)];
    nameLabel.text = cinemaModel.name;
    nameLabel.font =  [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:15];
    [cinemaButton addSubview:nameLabel];
    //地址label
    UILabel * addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLabel.frame), kScreenSize.width, 20)];
    addressLabel.text = cinemaModel.address;
    addressLabel.font  =[UIFont systemFontOfSize:13.0];
    addressLabel.textColor = [UIColor darkGrayColor];
    [cinemaButton addSubview:addressLabel];
    
    [headerView addSubview:cinemaButton];
    
    //scrollView
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40+CGRectGetMaxY(addressLabel.frame), kScreenSize.width, 200)];
    [headerView addSubview:scrollView];

    for (int i = 0; i < self.headerArr.count; i ++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(w*i, 0, w, 200)];
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, w-20, 150)];
        
        [button addTarget:self action:@selector(movieBtnCick:) forControlEvents:UIControlEventTouchUpInside];
        MovieInHeaderModel * model = self.headerArr[i];
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"] ];
        //设置button点击状态效果
        NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:@"点击查看电影"];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [attributeStr length])];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:16] range:NSMakeRange(0, [attributeStr length])];
        
        [button setAttributedTitle:attributeStr forState:UIControlStateSelected];
        
        
        //第一个button设置为点击状态
        if (i==0) {
            button.selected = YES;
            self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10+CGRectGetMaxY(scrollView.frame), kScreenSize.width, 30)];
            self.dateLabel.backgroundColor =  [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
            self.dateLabel.textAlignment = NSTextAlignmentCenter;
            self.dateLabel.text = [NSString stringWithFormat:@"“%@” 今日上映",model.title];
            self.dateLabel.font = [UIFont systemFontOfSize:16.0];
            self.dateLabel.textColor = myRed;
            [headerView addSubview:self.dateLabel];
        }
        //电影id作为按钮的tag值传过去
        button.tag = model.movieId;

        [view addSubview:button];
        
        UILabel * movNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(button.frame), w-20, 25)];
        movNameLabel.textAlignment = NSTextAlignmentCenter;
        movNameLabel.text = model.title;
        movNameLabel.adjustsFontSizeToFitWidth = YES;
        movNameLabel.font = [UIFont systemFontOfSize:15.0];
        UILabel * otherLabel =  [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(movNameLabel.frame), w-20, 25)];
        otherLabel.textAlignment = NSTextAlignmentCenter;
        otherLabel.font = [UIFont systemFontOfSize:12.0];
        otherLabel.text = [NSString stringWithFormat:@"%@-%@",model.length,model.type];
        otherLabel.numberOfLines=0;
        otherLabel.adjustsFontSizeToFitWidth = YES;
        [view addSubview:movNameLabel];
        [view addSubview:otherLabel];
        
        scrollView.showsHorizontalScrollIndicator = NO;
        [scrollView addSubview:view];
    }
    scrollView.contentSize = CGSizeMake(w*self.headerArr.count, 0);
    
    
    
    
    self.tableView.tableHeaderView = headerView;

}

- (void)movieBtnCick:(UIButton *)button{
    
    if (button.selected) {
        NSLog(@"跳入电影界面");
        
        
        return;
    }
    
    //如果不是当前事件取消点击效果
    NSInteger myTag = button.tag;
    for (MovieInHeaderModel * movieModel in self.headerArr) {
    
    UIButton * myButton = (UIButton *)[self.view viewWithTag:movieModel.movieId];
        if (movieModel.movieId!=myTag) {
            myButton.selected= NO;
        }else{
            self.dateLabel.text = [NSString stringWithFormat:@"“%@” 今日上映",movieModel.title];
            myButton.selected = YES;
        }
    }
    //如果当前按钮已被点击，直接跳过方法

    //否则 当前button tag 传给当前标志位
    self.currentTag = button.tag;
    
    [self downloadDisplayTimeDataWithMovieId:button.tag];
    
    
    
}


- (void)initUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CinemaDetailCell" bundle:nil] forCellReuseIdentifier:kCinemaDetailCellId];
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CinemaDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:kCinemaDetailCellId forIndexPath:indexPath];
    SofCinemaModel * model  =self.dataArr[indexPath.row];
    cell.niv = self.navigationController;
    [cell showDataWithSModel:model];
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end

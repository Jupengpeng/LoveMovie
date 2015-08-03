//
//  SearchResultController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "SearchResultController.h"

@interface SearchResultController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
    int fold[2] ;
    
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic) int currentPage;

@end

@implementation SearchResultController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    _dataArr = [[NSMutableArray alloc]init];
    
    fold[0] = 1;
//    fold[1] = 1;
    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self initUI];
    [self firstDownload];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)initUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SearhResultCell" bundle:nil] forCellReuseIdentifier:@"SearhResultCell"];
}

- (void)firstDownload{
    self.currentPage =1;
    NSString * url = [NSString stringWithFormat:kSearchResultUrl,3,self.keyWords,self.currentPage];
    [self downloadDataWithUrl:url];
}


- (void)downloadDataWithUrl:(NSString *)url{
    
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray * movieArr = [[NSMutableArray alloc]init];
            NSMutableArray * personArr= [[NSMutableArray alloc]init];
            for (NSDictionary * movieDict in dict[@"movies"]) {
                SearchResultModel * model = [[SearchResultModel alloc]init];
                [model setValuesForKeysWithDictionary:movieDict];
                [movieArr addObject:model];
            }
            for (NSDictionary * persondict in dict[@"persons"]) {
                SearchResultModel * model = [[SearchResultModel alloc]init];
                [model setValuesForKeysWithDictionary:persondict];
                [personArr addObject:model];
            }
            
            [_dataArr addObjectsFromArray:@[movieArr,personArr]] ;
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr=[NSArray arrayWithArray: self.dataArr[section]];
    
    return fold[section]==0 ? [arr count] : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel * view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 40)];
    view.userInteractionEnabled = YES;

    view.layer.cornerRadius = 2.0;
    view.layer.borderWidth =2.0f;
    view.layer.borderColor = myLight.CGColor;
    view.textColor = [UIColor whiteColor];
    view.font =[UIFont systemFontOfSize:14.0];
    view.numberOfLines = 0;
    view.backgroundColor = myRed;
    view.tag = section + 901;
    view.textAlignment = NSTextAlignmentCenter;
    if (section==0) {
        view.text = fold[section] ==0 ? @"电影搜索结果\n点击收起   " : @"电影搜索结果\n点击展开   ";
    }else{
        view.text = fold[section] ==0 ? @"影人搜索结果\n点击收起   " : @"影人搜索结果\n点击展开   ";
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnHeaderView:)];
    [view addGestureRecognizer:tap];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}

- (void)tapOnHeaderView:(UITapGestureRecognizer *)tap {
    UIView *headerView = tap.view; // 取到我们点击的是哪个view
    
    // 取到对应的section
    NSInteger section = headerView.tag - 901;
    
    fold[section] ^= 1;
    // fold [0 0 0 1 0]
    // section: 2
    // fold[section]: fold[2]: 0
    // fold[2] ^= 1 0^=1 1
    //      0 0 1 0 1
    //    ^ 0 1 0 0 1
    //   -------------
    //      0 1 1 0 0
    // 异或：相异为1，相同为0
    
    // tableView的局部刷新
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearhResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearhResultCell" forIndexPath:indexPath];
    NSArray * arr = self.dataArr[indexPath.section];
    SearchResultModel * model = arr[indexPath.row];
    
    [cell showDataWithResultModel:model];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}



@end

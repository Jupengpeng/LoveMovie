//
//  ReviewDetailViewController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/29.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "ReviewDetailViewController.h"

@interface ReviewDetailViewController ()<UIWebViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
}
@property (nonatomic,strong) UIWebView * webView;

@end

@implementation ReviewDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self initUI];
    [self initData];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-113)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    UIView * funcLabel  = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 49)];
    funcLabel.backgroundColor= myLight;
    //评论按钮
    UIButton * commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 25, 25)];
    [commentBtn setBackgroundImage:[UIImage imageNamed:@"icon_comment 4"] forState:UIControlStateNormal];
    [funcLabel addSubview:commentBtn];
    [commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    //评论角标
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(commentBtn.frame.size.width-15, 0,20, 12)];
    self.numberLabel.backgroundColor = [UIColor redColor];
    self.numberLabel.font = [UIFont systemFontOfSize:13.0];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.layer.cornerRadius = 6;
    self.numberLabel.adjustsFontSizeToFitWidth=YES;
    self.numberLabel.clipsToBounds = YES;
    [commentBtn addSubview:self.numberLabel];
    //相关电影按钮
    UIButton * relationBtn = [JPControl createButtonWithFrame:CGRectMake(kScreenSize.width-130, 10, 120, 30) borderColor:[UIColor blackColor] borderWidth:0.6f titleColor:[UIColor blackColor] adjustWidth:YES textAligment:NSTextAlignmentCenter target:self action:@selector(relationClick:)];
    [relationBtn setTitle:@"相关电影/影人" forState:UIControlStateNormal];
    relationBtn.clipsToBounds = YES;
    relationBtn.layer.cornerRadius = 15;
    [funcLabel addSubview:relationBtn];
    
    
    
    [self.view addSubview:funcLabel];
    
    //相关电影和影人view
    self.relationView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0)];
    self.relationView.clipsToBounds = YES;
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 50)];
    self.relationView.backgroundColor = [UIColor whiteColor];
    
    titleLabel.text = @"相关电影/影人";
    titleLabel.layer.borderWidth = 0.5f;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.relationView addSubview:titleLabel];
    [self.view addSubview:self.relationView];
    
    
    self.blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height-49)];
    self.blackView.backgroundColor =   [[UIColor blackColor]colorWithAlphaComponent:0.8];
    
}
//跳转进入评论界面
- (void)commentClick:(UIButton *)button{
    self.relationView.frame =CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0);
    [self.blackView removeFromSuperview];    NewsCommentsController * cVC= [[NewsCommentsController alloc]init];
    [self.navigationController pushViewController:cVC animated:YES];
     
    
    
}

- (void)relationClick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        //添加视图

        CGFloat w = 70;

        UIFont * font = [UIFont systemFontOfSize:11.0f];
            UIView * relatedView=  [[UIView alloc]initWithFrame:CGRectMake(10, 60, w, 155)];
            UIButton * relatedButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, w, 100)];
            relatedButton.clipsToBounds = YES;
            [relatedButton setContentMode:UIViewContentModeScaleAspectFill];
            CGFloat h = [LZXHelper textHeightFromTextString:self.reviewDetaiObjModel.name width:w fontSize:11.0f];
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(relatedButton.frame)+5, w, h)];
            titleLabel.numberOfLines = 0;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font  = font;
            //加载数据
            [relatedButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.reviewDetaiObjModel.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"empty"]];
            
            titleLabel.text = self.reviewDetaiObjModel.name;
            
            
            [relatedView addSubview:relatedButton];
            [relatedView addSubview:titleLabel];
                UILabel * yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,5+ CGRectGetMaxY(titleLabel.frame), w, 10)];
                yearLabel.font = font;
                yearLabel.textAlignment = NSTextAlignmentCenter;
                yearLabel.text  =  self.reviewDetaiObjModel.releaseDate;
                [relatedView addSubview:yearLabel];
                [relatedButton addTarget:self action:@selector(movieClick:) forControlEvents:UIControlEventTouchUpInside];

            relatedButton.tag = self.reviewDetaiObjModel.id;
            [self.relationView addSubview:relatedView];
        
        //显示阴影和添加视图
        [self.navigationController.view addSubview:self.blackView];
        [self.navigationController.view addSubview:self.relationView];
        //显示动画
        [UIView animateWithDuration:0.25 animations:^{
            
            self.relationView.frame = CGRectMake(0, kScreenSize.height-210-49, kScreenSize.width, 210);
            
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self.blackView removeFromSuperview];
            self.relationView.frame =CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 0);
        }];    }
    
}

- (void)movieClick:(UIButton *)button{
    
}


- (void)initData{
    NSString * url = [NSString stringWithFormat:kReviewDetailUrl,self.reviewId];
    
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            ReviewDetailModel * reviewDetModel = [[ReviewDetailModel alloc]init];
            [reviewDetModel setValuesForKeysWithDictionary:dict];
            if (!self.reviewDetaiObjModel) {
                self.reviewDetaiObjModel = [[ReviewDetaiObjModel alloc]init];
            }
            [self.reviewDetaiObjModel setValuesForKeysWithDictionary:reviewDetModel.relatedObj];

            [self showDataWithReviewDetailModel:reviewDetModel];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BBLog(@"下载失败");
    }];
    
    
    
}

- (void)showDataWithReviewDetailModel:(ReviewDetailModel *)model{
    self.numberLabel.text =[NSString stringWithFormat:@"%d" ,model.commentCount];
    
    NSMutableString * content=[NSMutableString stringWithString: model.content];
    [content insertString:[NSString stringWithFormat:@"<h2>%@</h2>",model.title] atIndex:0];
    [self.webView  loadHTMLString:content baseURL:nil];
    
}

#pragma mark - <UIWebViewDelegate>


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    //html便利图片 改变宽度
    
    NSString* content = [NSString stringWithFormat:@"var images = document.images;"
                         "for(var i=0;i<images.length;i++){"
                         "    images[i].width = %f"
                         "}",kScreenSize.width-10];
    
    [self.webView stringByEvaluatingJavaScriptFromString:content];
    [SVProgressHUD dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end

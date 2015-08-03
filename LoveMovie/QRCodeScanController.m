//
//  QRCodeScanController.m
//  LoveMovie
//
//  Created by qianfeng on 15/7/31.
//  Copyright (c) 2015年 JP. All rights reserved.
//

#import "QRCodeScanController.h"

@interface QRCodeScanController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    int showTag ;
}
//输入设备 摄像头或者麦克风
@property (nonatomic) AVCaptureDevice * device;
//输入 使用设备进行初始化
@property (nonatomic) AVCaptureDeviceInput * input;
//会话 把输入输出结合
@property (nonatomic) AVCaptureSession * session;
//元数据输出 可以指定格式 例如二维码 产生就会有输出
@property  (nonatomic) AVCaptureMetadataOutput * output;
//视频流 作为预览曾
@property (nonatomic) AVCaptureVideoPreviewLayer * previewLayer;

@property (nonatomic) UIAlertView * alertView;
@end

@implementation QRCodeScanController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    if (self.session) {
        [self.session startRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = myLight;
    showTag = 1;
    UIButton *button = [MyControl creatButtonWithFrame:CGRectMake(0, 0, 17, 26) target:self sel:@selector(pop) tag:0 image:@"white_right_arrow" title:nil];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;

    
    [self addTitleViewWithTitle:@"扫描二维码"];
    
    [self initQRScan];
    


}

- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initQRScan{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //使用设备初始化输入
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    //初始化输出，这里还没有指定那种类型的输出，后面指定
    self.output = [[AVCaptureMetadataOutput alloc]init];
    
    //当二维码被捕获后，输出调用的代理方法
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //产生会话，并添加输入输出
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    //指定output的类型为二维码,一旦扫描到二维码产生输出，注意设置类型一定要放到添加到session之后
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //创建预览层时时展示捕获的图像
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    self.previewLayer.frame = CGRectMake(20, 100, self.view.bounds.size.width-40, self.view.bounds.size.width-40);
    //设置视频填充模式
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.borderWidth = 10.0f;
    self.previewLayer.borderColor = [myRed colorWithAlphaComponent:0.6].CGColor;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.session startRunning];
}

//一旦扫描到二维码，会调用的代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject * object = [metadataObjects firstObject];
        NSString * qrString = object.stringValue;
        NSRange range= [qrString rangeOfString:@""];
//        if (range.location != NSNotFound ) {
        if (1) {
            QRDetailViewController * qVC = [[QRDetailViewController alloc]init];
            qVC.qrString = qrString;
            [self.navigationController pushViewController:qVC animated:YES];
            [self.session stopRunning];
            
        }else{
            if (!self.alertView) {
                self.alertView = [[UIAlertView alloc]initWithTitle:@"网址格式不正确" message:@"请扫描您的电影票" delegate:self cancelButtonTitle:@"重新扫描" otherButtonTitles: nil];
            }
            while (showTag) {
                [self.alertView show];
                [self.session stopRunning];

                showTag = 0;
            }


            
            
        }

    }
    
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self.session startRunning];
    showTag = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end

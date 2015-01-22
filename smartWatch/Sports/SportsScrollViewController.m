//
//  SportsScrollViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-5.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "SportsScrollViewController.h"

#define TABController_Height    (0)
#define NAV_HEIGHT              (self.navigationController.navigationBar.frame.size.height)
#define STATUS_BAR_HEIGHT       ([[UIApplication sharedApplication] statusBarFrame].size.height)

@interface SportsScrollViewController ()

@end

@implementation SportsScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _personInfo = [PersonDetaiInfo sharedInstance];
    
    [[ConnectionManager sharedInstance]setDelegate:self];
    
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _circleViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SportsCircleID"];
    _circleViewController.delegate = self;
    _detailViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SportsDetailID"];
    
    float total = STATUS_BAR_HEIGHT + NAV_HEIGHT;
    
    [_circleViewController.view setFrame:CGRectOffset(CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height), 0, TABController_Height)];
    [_detailViewController.view setFrame:CGRectOffset(CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height), 0, TABController_Height + DEVICE_HEIGHT- total)];
    
    [_scrollView setContentSize:CGSizeMake(0, DEVICE_HEIGHT*2- total*2)];
    
    [_scrollView addSubview:_circleViewController.view];
    [_scrollView addSubview:_detailViewController.view];
    [_scrollView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - SportsCircleViewControllerDelegate <NSObject>
-(void)leftButtonTouch
{
    
}
-(void)rightButtonTouch
{
    
}
-(void)pushMoreButtonTouch
{
    NSUInteger total = STATUS_BAR_HEIGHT + NAV_HEIGHT;
    [_scrollView setContentOffset:CGPointMake(0, TABController_Height + DEVICE_HEIGHT- total) animated:YES];
}

-(void)syncButtonTouch
{
    [ProgressHUD show:@"同步中..."];
    [[ConnectionManager sharedInstance].deviceObject sendCommandydxx_requestHistoryInfo:ConnectionManagerCommadEnum_YD_lsjl];
}
#pragma mark -ConnectionManagerDelegate
- (void) didDiscoverDevice:(oneLedDeviceObject*)device
{
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",@"发现设备:",device.name]];
}
- (void) didDisconnectWithDevice:(oneLedDeviceObject*)device
{
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",@"断开连接:",device.name]];
}
- (void) didConnectWithDevice:(oneLedDeviceObject*)device
{
    
}
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_YD_lsjl) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe2&&byteValue[1] == 0x12){
            _sportModel = [[sportOneDayInfoModel alloc]initWithData:data];
            [_personInfo addSportReadingWithModel:_sportModel];
            [[ConnectionManager sharedInstance].deviceObject sendCommandydxx_requestPerAck:ConnectionManagerCommadEnum_YD_lsjl];
        }else if (byteValue[0] == 0xe2&&byteValue[1] == 0x02) {
            [ProgressHUD showSuccess:@"同步完成"];
        }
        
    }
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd{
    
}
@end

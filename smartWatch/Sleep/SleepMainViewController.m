//
//  SleepMainViewController.m
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "SleepMainViewController.h"

@interface SleepMainViewController ()

@end

@implementation SleepMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)IsRegisterButtonTouch:(UIButton *)sender {
    [[ConnectionManager sharedInstance].deviceObject sendCommandyhzc_requestDeviceWhetherRegistered];
}

- (IBAction)resetButtonTouch:(UIButton *)sender {
     [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendDeviceReset];
}

#pragma mark - ConnectionManagerDelegate
- (void) didReciveCommandResponseData:(NSData*)data
{
    
}
@end

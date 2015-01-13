//
//  AlarmListViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-2.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "AlarmListViewController.h"

@interface AlarmListViewController ()

@end

@implementation AlarmListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ProgressHUD show:@"查询闹钟中"];
    [[ConnectionManager sharedInstance] setDelegate:self];
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_requestAlarmInfo:ConnectionManagerCommadEnum_SZ_nzcx];
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
//alarmListCellIdentifier
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _alarmCell = [tableView dequeueReusableCellWithIdentifier:@"alarmListCellIdentifier" forIndexPath:indexPath];
    return _alarmCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"alarmSelectIdentiifer" sender:nil];
}
#pragma mark - ConnectionManager Delegate
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SZ_nzcx) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe5&&byteValue[1] == 0x0b){
            [ProgressHUD dismiss];
        }
        
    }

}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd
{
    
}

@end

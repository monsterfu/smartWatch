//
//  AntiLostViewController.m
//  smartWatch
//
//  Created by Monster on 15/1/29.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "AntiLostViewController.h"

@interface AntiLostViewController ()

@end

@implementation AntiLostViewController

-(void)viewDidAppear:(BOOL)animated{
    [ConnectionManager sharedInstance].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView setEmptyFootView];
    [ConnectionManager sharedInstance].delegate = self;
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
//antiLostCellIdentifier

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:@"antiLostCellIdentifier" forIndexPath:indexPath];
    UILabel* nameLabel = (UILabel*)[_cell viewWithTag:1];
    UISwitch* switchControl = (UISwitch*)[_cell viewWithTag:2];
    
    if (indexPath.section == 0) {
        nameLabel.text = @"手机防丢";
    }else{
        nameLabel.text = @"SmartAM防丢";
    }
    
    return _cell;
}

#pragma mark - ConnectionManager Delegate
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SZ_nzcx) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe5&&byteValue[1] == 0x0b){
//            [ProgressHUD dismiss];
//            Byte* byteValueOne = (Byte*)byteValue + 2;
//            for (NSUInteger idx = 0; idx < 3; idx ++) {
//                Byte* byteValueDest = byteValueOne + 3*idx;
//                NSData* alarmData = [NSData dataWithBytes:byteValueDest length:3];
//                AlarmModel* alarmModel = [_alarmArray objectAtIndex:idx];
//                alarmModel = [alarmModel initWithData:alarmData];
//            }
            [_tableView reloadData];
        }
        
    }
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SZ_nzsz) {
        [ProgressHUD showSuccess:@"闹钟设置成功!"];
    }
}
#pragma mark - alarmTableViewCellDelegate
-(void)alarmTableViewCell_SwitchOpen:(BOOL)open tag:(NSUInteger)tag
{
    
    [ProgressHUD show:@"闹钟设置中"];
//    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendAlarmInfo:_alarmArray cmd:ConnectionManagerCommadEnum_SZ_nzsz];
//}
}
@end

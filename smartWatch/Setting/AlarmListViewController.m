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

-(void)viewDidAppear:(BOOL)animated
{
    [_tableView reloadData];
    [[ConnectionManager sharedInstance] setDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [ProgressHUD show:@"查询闹钟中"];
    [[ConnectionManager sharedInstance] setDelegate:self];
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_requestAlarmInfo:ConnectionManagerCommadEnum_SZ_nzcx];
    
    _alarmArray = [NSMutableArray array];
    
    for (NSUInteger idx = 0; idx < 3; idx ++) {
        AlarmModel* alarmModel = [[AlarmModel alloc]initWithData:nil];
        [_alarmArray addObject:alarmModel];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"alarmSelectIdentiifer"]) {
        _alarmEditViewController = (AlarmEditViewController*)segue.destinationViewController;
        _alarmEditViewController.alarmModel = (AlarmModel*)sender;
        _alarmEditViewController.alarmArray = _alarmArray;
    }
}

//alarmListCellIdentifier
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _alarmCell = [tableView dequeueReusableCellWithIdentifier:@"alarmListCellIdentifier" forIndexPath:indexPath];
    _alarmModel = [_alarmArray objectAtIndex:indexPath.row];
    _alarmCell.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",_alarmModel.hour,_alarmModel.min];
    _alarmCell.periodLabel.text = [_alarmModel repeatDetailString];
    _alarmCell.switchOpen.on = _alarmModel.enable;
    _alarmCell.tag = indexPath.row;
    _alarmCell.delegate = self;
    return _alarmCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"alarmSelectIdentiifer" sender:[_alarmArray objectAtIndex:indexPath.row]];
}
#pragma mark - ConnectionManager Delegate
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SZ_nzcx) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe5&&byteValue[1] == 0x0b){
            [ProgressHUD dismiss];
            Byte* byteValueOne = (Byte*)byteValue + 2;
            for (NSUInteger idx = 0; idx < 3; idx ++) {
                Byte* byteValueDest = byteValueOne + 3*idx;
                NSData* alarmData = [NSData dataWithBytes:byteValueDest length:3];
                AlarmModel* alarmModel = [_alarmArray objectAtIndex:idx];
                alarmModel = [alarmModel initWithData:alarmData];
            }
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
    _alarmModel = [_alarmArray objectAtIndex:tag];
    _alarmModel.enable = open;
    
    [ProgressHUD show:@"闹钟设置中"];
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendAlarmInfo:_alarmArray cmd:ConnectionManagerCommadEnum_SZ_nzsz];
}
@end

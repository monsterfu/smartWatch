//
//  AlarmEditViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "AlarmEditViewController.h"

@interface AlarmEditViewController ()

@end

@implementation AlarmEditViewController

-(void)viewDidAppear:(BOOL)animated
{
    _repeatCell.detailTextLabel.text = [_alarmModel repeatDetailString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _editDate = [NSDate dateWithHour:_alarmModel.hour Min:_alarmModel.min];
    
    [ConnectionManager sharedInstance].delegate = self;
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
    _weekNumSelectViewController = (WeekNumSelectViewController*)segue.destinationViewController;
    _weekNumSelectViewController.valueArray = sender;
}


- (IBAction)doneButtonTouch:(UIBarButtonItem *)sender {
    _alarmModel.hour = _editDate.hour;
    _alarmModel.min = _editDate.minute;
    
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendAlarmInfo:_alarmArray cmd:ConnectionManagerCommadEnum_SZ_nzsz];
}
- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    _editDate = sender.date;
    _cell.textLabel.text = [NSString stringWithFormat:@"%02d:%02d",_editDate.hour,_editDate.minute];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _repeatCell = [tableView dequeueReusableCellWithIdentifier:@"editAlarmRepeatCell" forIndexPath:indexPath];
        _repeatCell.detailTextLabel.text = [_alarmModel repeatDetailString];
        return _repeatCell;
    }else{
        _cell = [tableView dequeueReusableCellWithIdentifier:@"editAlarmDateCell" forIndexPath:indexPath];
        _cell.textLabel.text = [_alarmModel timeDetailString];
        return _cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"alarmWeekNumSelectIdentifier" sender:_alarmModel.valueArray];
    }else{
        [_datePicker setDate:_editDate animated:YES];
    }
    
}
#pragma mark - ConnectionManager Delegate
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SZ_nzsz) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end

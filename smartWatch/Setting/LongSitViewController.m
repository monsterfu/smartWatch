//
//  LongSitViewController.m
//  smartWatch
//
//  Created by Monster on 14-12-30.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "LongSitViewController.h"

@interface LongSitViewController ()

@end

@implementation LongSitViewController
-(void)viewDidAppear:(BOOL)animated
{
    _gapCell.detailTextLabel.text = [NSString longTimeGapIndex:_longsitModelData.remindGap];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _startOneDate = [USER_DEFAULT objectForKey:KEY_LONGSIT_STARTTIMEONE];
    _startTwoDate = [USER_DEFAULT objectForKey:KEY_LONGSIT_STARTTIMETWO];
    _endOneDate = [USER_DEFAULT objectForKey:KEY_LONGSIT_ENDTIMEONE];
    _endTwoDate = [USER_DEFAULT objectForKey:KEY_LONGSIT_ENDTIMETWO];
    
    if (_startOneDate == nil) {
        _startOneDate = [NSDate date];
    }
    if (_startTwoDate == nil) {
        _startTwoDate = [NSDate date];
    }
    if (_endOneDate == nil) {
        _endOneDate = [NSDate date];
    }
    if (_endTwoDate == nil) {
        _endTwoDate = [NSDate date];
    }
    
    _longsitModelData = [[longSitModel alloc]init];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:_startOneDate];
    _longsitModelData.startHour1 = [comps hour];
    _longsitModelData.startMin1 = [comps minute];
    
    comps = [calendar components:unitFlags fromDate:_endOneDate];
    _longsitModelData.endHour1 = [comps hour];
    _longsitModelData.endMin1 = [comps minute];
    
    comps = [calendar components:unitFlags fromDate:_startTwoDate];
    _longsitModelData.startHour2 = [comps hour];
    _longsitModelData.startMin2 = [comps minute];
    
    comps = [calendar components:unitFlags fromDate:_endTwoDate];
    _longsitModelData.endHour2 = [comps hour];
    _longsitModelData.endMin2 = [comps minute];
    
    _longsitModelData.remindGap = [USER_DEFAULT integerForKey:KEY_longSitRemindGap];
    _longsitModelData.open = [USER_DEFAULT boolForKey:KEY_longSitRemindOpen];
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
    if ([segue.identifier isEqualToString:@"longSitGapSelectIdentifier"]) {
        _gapSelectViewController = [segue destinationViewController];
        _gapSelectViewController.longsitModelData = _longsitModelData;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = nil;
    if (indexPath.section == 0&&indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitEnableCellIdentifier"];
        UISwitch* switchButton = (UISwitch*)[cell viewWithTag:2];
        [switchButton addTarget:self action:@selector(enableSwitchButtonTouched:) forControlEvents:UIControlEventValueChanged];
        switchButton.on = _longsitModelData.open;
    }else if (indexPath.section == 0&&indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitGapCellIdentifier"];
        cell.detailTextLabel.text = [NSString longTimeGapIndex:_longsitModelData.remindGap];
        _gapCell = cell;
    }else if (indexPath.section == 1&&indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitTimeCellIdentifier" forIndexPath:indexPath];
        _startOneButton = (UIButton*)[cell viewWithTag:2];
        _selectButton = _startOneButton;
        [_startOneButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
        _endOneButton = (UIButton*)[cell viewWithTag:4];
        [_endOneButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
    }else if (indexPath.section == 1&&indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitTimeCellIdentifier" forIndexPath:indexPath];
        _startTwoButton = (UIButton*)[cell viewWithTag:2];
        [_startTwoButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
        _endTwoButton = (UIButton*)[cell viewWithTag:4];
        [_endTwoButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (![USER_DEFAULT boolForKey:KEY_ISLOGIN_INFO]) {
    //        [self.navigationController.tabBarController performSegueWithIdentifier:@"userLoginIdentifier" sender:nil];
    //    }else{
    //        [self.navigationController.tabBarController performSegueWithIdentifier:@"searchDetailIdentifier" sender:[_dataArray objectAtIndex:indexPath.row]];
    //    }
}
#pragma mark -- buttonTouch
- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    
    if (_selectButton == _startOneButton) {
        _startOneDate = sender.date;
    }else if (_selectButton == _endOneButton) {
        _endOneDate = sender.date;
    }else if (_selectButton == _startTwoButton) {
        _startTwoDate = sender.date;
    }else if (_selectButton == _endTwoButton) {
        _endTwoDate = sender.date;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:sender.date];
    
    [_selectButton setTitle:[NSString stringWithFormat:@"%2ld:%2ld",(long)[comps hour],(long)[comps minute]] forState:UIControlStateNormal];
}

-(void)enableSwitchButtonTouched:(UISwitch*)switchValue{
    NSLog(@"switchValue:%d",switchValue.on);
}
-(void)datePickerShow:(UIButton*)sender
{
    _selectButton = sender;
    if (sender == _startOneButton) {
        [_datePickerView setDate:_startOneDate animated:YES];
    }else if (sender == _endOneButton) {
        [_datePickerView setDate:_endOneDate animated:YES];
    }else if (sender == _startTwoButton) {
        [_datePickerView setDate:_startTwoDate animated:YES];
    }else if (sender == _endTwoButton) {
        [_datePickerView setDate:_endTwoDate animated:YES];
    }
}
@end

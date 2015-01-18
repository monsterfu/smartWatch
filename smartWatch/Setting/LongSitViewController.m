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
    _weekNumCell.detailTextLabel.text = [_longsitModelData repeatDetailString];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    NSData* aData = [USER_DEFAULT objectForKey:KEY_LONGSIT_ALL];
    _longsitModelData = [NSKeyedUnarchiver unarchiveObjectWithData:aData];
    
//    _longsitSwitch.on = _longsitModelData.open;
    
    if (_longsitModelData == nil) {
        _longsitModelData = [[longSitModel alloc]init];
    }
    
    if (_longsitModelData.startDate1 == nil) {
        _longsitModelData.startDate1 = [NSDate date];
    }
    if (_longsitModelData.startDate2 == nil) {
        _longsitModelData.startDate2 = [NSDate date];
    }
    if (_longsitModelData.endDate1 == nil) {
        _longsitModelData.endDate1 = [NSDate date];
    }
    if (_longsitModelData.endDate2 == nil) {
        _longsitModelData.endDate2 = [NSDate date];
    }
    if (_longsitModelData.valueArray == nil) {
        _longsitModelData.valueArray = [NSMutableArray arrayWithArray:@[[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO]]];
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
    if ([segue.identifier isEqualToString:@"longSitGapSelectIdentifier"]) {
        _gapSelectViewController = [segue destinationViewController];
        _gapSelectViewController.longsitModelData = _longsitModelData;
    }else if ([segue.identifier isEqualToString:@"weekNumSelectIdentifier"]) {
        _weekSelectViewController = [segue destinationViewController];
        _weekSelectViewController.valueArray = _longsitModelData.valueArray;
    }
}
- (IBAction)unwindToYellowViewController:(UIStoryboardSegue *)segue {
    UIViewController *sourceViewController = segue.sourceViewController;
    
    if ([sourceViewController isKindOfClass:[WeekNumSelectViewController class]]) {
        
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
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = nil;
    if (indexPath.section == 0&&indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitEnableCellIdentifier"];
        UISwitch* switchButton = (UISwitch*)[cell viewWithTag:20];
        [switchButton addTarget:self action:@selector(enableSwitchButtonTouched:) forControlEvents:UIControlEventValueChanged];
        switchButton.on = _longsitModelData.open;
    }else if (indexPath.section == 0&&indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitGapCellIdentifier"];
        cell.textLabel.text = @"间隔";
        cell.detailTextLabel.text = [NSString longTimeGapIndex:_longsitModelData.remindGap];
        _gapCell = cell;
    }else if (indexPath.section == 0&&indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitGapCellIdentifier"];
        cell.textLabel.text = @"重复";
        cell.detailTextLabel.text = [_longsitModelData repeatDetailString];
        _weekNumCell = cell;
    }else if (indexPath.section == 1&&indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitTimeCellIdentifier" forIndexPath:indexPath];
        _startOneButton = (UIButton*)[cell viewWithTag:2];
        _selectButton = _startOneButton;
        [_startOneButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
        _endOneButton = (UIButton*)[cell viewWithTag:4];
        [_endOneButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:_longsitModelData.startDate1];
        [_startOneButton setTitle:[NSString stringWithFormat:@"%02ld:%02ld",(long)[comps hour],(long)[comps minute]] forState:UIControlStateNormal];
        comps = [calendar components:unitFlags fromDate:_longsitModelData.endDate1];
        [_endOneButton setTitle:[NSString stringWithFormat:@"%02ld:%02ld",(long)[comps hour],(long)[comps minute]] forState:UIControlStateNormal];
        
    }else if (indexPath.section == 1&&indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"longSitTimeCellIdentifier" forIndexPath:indexPath];
        _startTwoButton = (UIButton*)[cell viewWithTag:2];
        [_startTwoButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
        _endTwoButton = (UIButton*)[cell viewWithTag:4];
        [_endTwoButton addTarget:self action:@selector(datePickerShow:) forControlEvents:UIControlEventTouchUpInside];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:_longsitModelData.startDate2];
        [_startTwoButton setTitle:[NSString stringWithFormat:@"%02ld:%02ld",(long)[comps hour],(long)[comps minute]] forState:UIControlStateNormal];
        comps = [calendar components:unitFlags fromDate:_longsitModelData.endDate2];
        [_endTwoButton setTitle:[NSString stringWithFormat:@"%02ld:%02ld",(long)[comps hour],(long)[comps minute]] forState:UIControlStateNormal];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&&indexPath.row == 1) {
        [self performSegueWithIdentifier:@"longSitGapSelectIdentifier" sender:_longsitModelData];
    }else if(indexPath.section == 0&&indexPath.row == 2){
        [self performSegueWithIdentifier:@"weekNumSelectIdentifier" sender:_longsitModelData];
    }
}
#pragma mark -- buttonTouch
- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    
    if (_selectButton == _startOneButton) {
        _longsitModelData.startDate1 = sender.date;
    }else if (_selectButton == _endOneButton) {
        _longsitModelData.endDate1 = sender.date;
    }else if (_selectButton == _startTwoButton) {
        _longsitModelData.startDate2 = sender.date;
    }else if (_selectButton == _endTwoButton) {
        _longsitModelData.endDate2 = sender.date;
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:sender.date];
    
    [_selectButton setTitle:[NSString stringWithFormat:@"%02ld:%02ld",(long)[comps hour],(long)[comps minute]] forState:UIControlStateNormal];
}

- (IBAction)saveButtonTouch:(UIBarButtonItem *)sender {
    if ([_longsitModelData.startDate1 isEqualToDate:_longsitModelData.endDate1]||[_longsitModelData.startDate2 isEqualToDate:_longsitModelData.endDate2]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"开始时间不能与结束时间相同" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    [ConnectionManager sharedInstance].delegate = self;
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendLongTimeSitRemind:_longsitModelData cmd:ConnectionManagerCommadEnum_JZTX_sz];
    [ProgressHUD show:@""];
}

- (IBAction)enableLongSitSet:(UISwitch *)sender {
    NSLog(@"switchValue:%d",sender.on);
    _longsitModelData.open = sender.on;
    [ConnectionManager sharedInstance].delegate = self;
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendLongTimeSitRemindEnable:sender.on cmd:ConnectionManagerCommadEnum_JZTX_kg];
    [ProgressHUD show:@""];
}

-(void)enableSwitchButtonTouched:(UISwitch*)switchValue{
    NSLog(@"switchValue:%d",switchValue.on);
    _longsitModelData.open = switchValue.on;
    [ConnectionManager sharedInstance].delegate = self;
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendLongTimeSitRemindEnable:switchValue.on cmd:ConnectionManagerCommadEnum_JZTX_kg];
    [ProgressHUD show:@""];
}
-(void)datePickerShow:(UIButton*)sender
{
    _selectButton = sender;
    if (sender == _startOneButton) {
        [_datePickerView setDate:_longsitModelData.startDate1 animated:YES];
    }else if (sender == _endOneButton) {
        [_datePickerView setDate:_longsitModelData.endDate1 animated:YES];
    }else if (sender == _startTwoButton) {
        [_datePickerView setDate:_longsitModelData.startDate2 animated:YES];
    }else if (sender == _endTwoButton) {
        [_datePickerView setDate:_longsitModelData.endDate2 animated:YES];
    }
}
#pragma mark - ConnectionManagerDelegate
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd
{
    [ProgressHUD showSuccess:@"完成"];
    if (cmd == ConnectionManagerCommadEnum_JZTX_sz) {
        [USER_DEFAULT removeObjectForKey:KEY_LONGSIT_ALL];
        NSData* aDate = [NSKeyedArchiver archivedDataWithRootObject:_longsitModelData];
        [USER_DEFAULT setObject:aDate forKey:KEY_LONGSIT_ALL];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

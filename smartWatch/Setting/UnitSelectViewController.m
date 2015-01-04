//
//  UnitSelectViewController.m
//  smartWatch
//
//  Created by Monster on 14-12-30.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "UnitSelectViewController.h"

@interface UnitSelectViewController ()

@end

@implementation UnitSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _heightUnitArray = @[@"Feet",@"Cm"];
    _weightUnitArray = @[@"Kg",@"Lb",@"St"];
    _lengthUnitArray = @[@"Km",@"Mile"];
    
    _heightUnit = [USER_DEFAULT integerForKey:KEY_HeightUnit];
    _weightUnit = [USER_DEFAULT integerForKey:KEY_WeightUnit];
    _lengthUnit = [USER_DEFAULT integerForKey:KEY_LengthUnit];
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
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"身高单位";
    }else if(section == 1){
        return @"体重单位";
    }else{
        return @"长度单位";
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return _heightUnitArray.count;
    }else if(section == 1){
        return _weightUnitArray.count;
    }else{
        return _lengthUnitArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"unitSelectCellIdentifier" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = [_heightUnitArray objectAtIndex:indexPath.row];
        if (indexPath.row == _heightUnit-1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else if(indexPath.section == 1){
        cell.textLabel.text = [_weightUnitArray objectAtIndex:indexPath.row];
        if (indexPath.row == _weightUnit-1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else{
        cell.textLabel.text = [_lengthUnitArray objectAtIndex:indexPath.row];
        if (indexPath.row == _lengthUnit-1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectionIndexPath;
    if (indexPath.section == 0) {
        selectionIndexPath = [NSIndexPath indexPathForRow:_heightUnit-1 inSection:0];
    }else if (indexPath.section == 1) {
        selectionIndexPath = [NSIndexPath indexPathForRow:_weightUnit-1 inSection:1];
    }else if (indexPath.section == 2) {
        selectionIndexPath = [NSIndexPath indexPathForRow:_lengthUnit-1 inSection:2];
    }
    
    UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
    checkedCell.accessoryType = UITableViewCellAccessoryNone;
    
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    // Deselect the row.
    //                _detailInfo.sex = [NSNumber numberWithBool:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        _heightUnit = indexPath.row + 1;
    }else if (indexPath.section == 1) {
        _weightUnit = indexPath.row + 1;
    }else if (indexPath.section == 2) {
        _lengthUnit = indexPath.row + 1;
    }
}
- (IBAction)saveButtonTouched:(UIBarButtonItem *)sender {
    [[ConnectionManager sharedInstance]setDelegate:self];
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendUnitWithHeightUnit:_heightUnit weightUnit:_weightUnit lengthUnit:_lengthUnit cmd:ConnectionManagerCommadEnum_SZ_dwsz];
    [ProgressHUD show:@"设置中"];
}

#pragma mark - ConnectionManager Delegate
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd
{
    [USER_DEFAULT removeObjectForKey:KEY_HeightUnit];
    [USER_DEFAULT removeObjectForKey:KEY_WeightUnit];
    [USER_DEFAULT removeObjectForKey:KEY_LengthUnit];
    [USER_DEFAULT setInteger:_heightUnit forKey:KEY_HeightUnit];
    [USER_DEFAULT setInteger:_weightUnit forKey:KEY_WeightUnit];
    [USER_DEFAULT setInteger:_lengthUnit forKey:KEY_LengthUnit];
    [USER_DEFAULT synchronize];
    
    [ProgressHUD showSuccess:@"设置成功"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end

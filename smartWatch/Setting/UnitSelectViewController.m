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
    [self.navigationController popViewControllerAnimated:YES];
}
@end

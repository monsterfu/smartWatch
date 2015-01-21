//
//  WeekNumSelectViewController.m
//  smartWatch
//
//  Created by Monster on 15/1/3.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "WeekNumSelectViewController.h"

@interface WeekNumSelectViewController ()

@end

@implementation WeekNumSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView setEmptyFootView];
    _titleArray = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}

//weekNumCellIdentifier
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weekNumCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    if ([[_valueArray objectAtIndex:indexPath.row] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL value = NO;
    if ([[_valueArray objectAtIndex:indexPath.row] boolValue])
    {
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:indexPath];
        checkedCell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        value = YES;
    }
    [_valueArray removeObjectAtIndex:indexPath.row];
    [_valueArray insertObject:[NSNumber numberWithBool:value] atIndex:indexPath.row];
    
}

- (IBAction)saveButtonTouched:(UIBarButtonItem *)sender {
//    _longsitModelData.valueArray = _valueArray;
    [self.navigationController popViewControllerAnimated:YES];
}
@end

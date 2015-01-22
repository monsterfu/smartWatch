//
//  SportsListViewController.m
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "SportsListViewController.h"

@interface SportsListViewController ()

@end

@implementation SportsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView setEmptyFootView];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _allsportsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sportsListCellIdentiifier" forIndexPath:indexPath];
    _sportCoreDataModel = [_allsportsArray objectAtIndex:indexPath.row];
    UILabel* stepNumLabel = (UILabel*)[cell viewWithTag:1];
    UILabel* distanceLabel = (UILabel*)[cell viewWithTag:2];
    UILabel* kcalLabel = (UILabel*)[cell viewWithTag:3];
    UILabel* dateLabel = (UILabel*)[cell viewWithTag:4];
    
    dateLabel.text = [_sportCoreDataModel.date formatString:NSDateFormatString_1];
    stepNumLabel.text = [NSString stringWithFormat:@"%ld",_sportCoreDataModel.totalStepNum.longValue];
    distanceLabel.text = [NSString stringWithFormat:@"%.1f",_sportCoreDataModel.distance.longValue/1000.0f];
    kcalLabel.text = [NSString stringWithFormat:@"%ld",_sportCoreDataModel.totalKcal.longValue];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"sportDetailIdentifier" sender:nil];
}
@end

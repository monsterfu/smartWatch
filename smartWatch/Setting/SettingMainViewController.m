//
//  SettingMainViewController.m
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "SettingMainViewController.h"

@interface SettingMainViewController ()

@end

@implementation SettingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    _titleArray = @[@"个人信息",@"单位设置",@"闹钟",@"久坐提醒",@"防丢卫士",@"工作模式",@"信息推送"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingMainCellIdentifier" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    }else if (indexPath.section == 1){
        cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row+2];
        
    }else if (indexPath.section == 2){
        cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row+6];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1&&indexPath.row == 0) {
        [self performSegueWithIdentifier:@"alarmListPushIdentifier" sender:nil];
    }else if (indexPath.section == 1&&indexPath.row == 1) {
        [self performSegueWithIdentifier:@"longsitContrlPushIdentifier" sender:nil];
    }else if (indexPath.section == 0&&indexPath.row == 1) {
        [self performSegueWithIdentifier:@"unitSelectPushIdentifier" sender:nil];
    }
    
//    if (![USER_DEFAULT boolForKey:KEY_ISLOGIN_INFO]) {
//        [self.navigationController.tabBarController performSegueWithIdentifier:@"userLoginIdentifier" sender:nil];
//    }else{
//        [self.navigationController.tabBarController performSegueWithIdentifier:@"searchDetailIdentifier" sender:[_dataArray objectAtIndex:indexPath.row]];
//    }
}
@end

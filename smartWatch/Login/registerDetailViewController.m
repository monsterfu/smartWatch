//
//  registerDetailViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "registerDetailViewController.h"

@interface registerDetailViewController ()

@end

@implementation registerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameCellArray = @[@"设置名字",@"昵称:"];
    ageCellArray = @[@"年龄",@"年龄:"];
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
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailTextCellIdentifier" forIndexPath:indexPath];
        UILabel* titleLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* tLabel = (UILabel*)[cell viewWithTag:2];
        _nameTextField = (UITextField*)[cell viewWithTag:3];
        _nameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _nameTextField.delegate = self;
        
        titleLabel.text = [nameCellArray objectAtIndex:0];
        tLabel.text = [nameCellArray objectAtIndex:1];
        
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailTextCellIdentifier" forIndexPath:indexPath];
        UILabel* titleLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* tLabel = (UILabel*)[cell viewWithTag:2];
        _ageTextField = (UITextField*)[cell viewWithTag:3];
        _ageTextField.keyboardType = UIKeyboardTypeNumberPad;
        _ageTextField.delegate = self;
        
        titleLabel.text = [ageCellArray objectAtIndex:0];
        tLabel.text = [ageCellArray objectAtIndex:1];
        
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailSexCellIdentifier" forIndexPath:indexPath];
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailWeightCellIdentifier" forIndexPath:indexPath];
    }else if (indexPath.section == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailHeightCellIdentifier" forIndexPath:indexPath];
    }else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailStepCellIdentifier" forIndexPath:indexPath];
    }else if (indexPath.section == 6){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailDoneCellIdentifier" forIndexPath:indexPath];
    }
    return cell;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
@end

//
//  registerDetailViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "registerDetailViewController.h"


#define NAV_HEIGHT              (self.navigationController.navigationBar.frame.size.height)
#define STATUS_BAR_HEIGHT       ([[UIApplication sharedApplication] statusBarFrame].size.height)

@interface registerDetailViewController ()

@end

@implementation registerDetailViewController
-(void)viewDidLayoutSubviews
{
    _tableView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT - STATUS_BAR_HEIGHT -STATUS_BAR_HEIGHT - 10);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameCellArray = @[@"设置名字",@"昵称:"];
    ageCellArray = @[@"年龄",@"年龄:"];
    destStepArray = @[@"目标步数",@"步数"];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 85;
        
    }else if (indexPath.section == 1){
        return 85;
        
    }else if (indexPath.section == 2){
        return 164;
        
    }else if (indexPath.section == 3){
        return 160;
        
    }else if (indexPath.section == 4){
        return 160;
    }else if (indexPath.section == 5){
        return 85;
        
    }else{
        return 85;
    }

}
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
        _maleButton = (UIButton*)[cell viewWithTag:1];
        _femaleButton = (UIButton*)[cell viewWithTag:2];
        
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailWeightCellIdentifier" forIndexPath:indexPath];
        _weightLabel = (UILabel*)[cell viewWithTag:1];
        _weightScrollView = (UIScrollView*)[cell viewWithTag:2];
        _weightImageView = (UIImageView*)[cell viewWithTag:3];
        
        [_weightScrollView setContentSize:CGSizeMake(_weightScrollView.frame.size.width*3, 0)];
        [_weightImageView setFrame:CGRectMake(0, 0, _weightImageView.frame.size.width*3, _weightImageView.frame.size.height)];
        [_weightImageView setImage:[UIImage imageNamed:@"login_scroll_1"]];
        
    }else if (indexPath.section == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailHeightCellIdentifier" forIndexPath:indexPath];
    }else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailTextCellIdentifier" forIndexPath:indexPath];
        UILabel* titleLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* tLabel = (UILabel*)[cell viewWithTag:2];
        _destStepNumField = (UITextField*)[cell viewWithTag:3];
        _destStepNumField.keyboardType = UIKeyboardTypeNumberPad;
        _destStepNumField.delegate = self;
        
        titleLabel.text = [destStepArray objectAtIndex:0];
        tLabel.text = [destStepArray objectAtIndex:1];
        
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
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    
}
@end

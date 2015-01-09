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
    
    [[ConnectionManager sharedInstance] setDelegate: self];
    
    _desStepNum = [USER_DEFAULT integerForKey:KEY_PersonDest_StepNum];
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
        
        _nameTextField.text = _personModel.nickName;
        
        titleLabel.text = [nameCellArray objectAtIndex:0];
        tLabel.text = [nameCellArray objectAtIndex:1];
        
    }else if (indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailTextCellIdentifier" forIndexPath:indexPath];
        UILabel* titleLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* tLabel = (UILabel*)[cell viewWithTag:2];
        _ageTextField = (UITextField*)[cell viewWithTag:3];
        _ageTextField.keyboardType = UIKeyboardTypeNumberPad;
        _ageTextField.delegate = self;
        
        _ageTextField.text = [NSString stringWithFormat:@"%lu",(unsigned long)_personModel.age];
        
        titleLabel.text = [ageCellArray objectAtIndex:0];
        tLabel.text = [ageCellArray objectAtIndex:1];
        
    }else if (indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailSexCellIdentifier" forIndexPath:indexPath];
        _maleButton = (UIButton*)[cell viewWithTag:1];
        
        _femaleButton = (UIButton*)[cell viewWithTag:2];
        
        if (_personModel.sex == 1) {
            [_maleButton setSelected:YES];
        }else{
            [_femaleButton setSelected:YES];
        }
        
        [_maleButton addTarget:self action:@selector(sexButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_femaleButton addTarget:self action:@selector(sexButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailWeightCellIdentifier" forIndexPath:indexPath];
        _weightLabel = (UILabel*)[cell viewWithTag:1];
        _weightScrollView = (UIScrollView*)[cell viewWithTag:2];
        _weightImageView = (UIImageView*)[cell viewWithTag:3];
        
        _weightLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_personModel.weight];
        
        [_weightScrollView setContentSize:CGSizeMake(_weightScrollView.frame.size.width*3, 0)];
        _weightScrollView.delegate = self;
        
        _weightGap = (210.0f - 10.0f)/_weightScrollView.contentSize.width;
        
        if (_personModel.weight > 10.0f) {
            [_weightScrollView setContentOffset:CGPointMake((_personModel.weight - 10.0f)/_weightGap, 0) animated:YES];
        }
        
        
    }else if (indexPath.section == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailHeightCellIdentifier" forIndexPath:indexPath];
        _heightLabel = (UILabel*)[cell viewWithTag:1];
        _heightScrollView = (UIScrollView*)[cell viewWithTag:2];
        _heightImageView = (UIImageView*)[cell viewWithTag:3];
        
        _heightLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_personModel.height];
        
        [_heightScrollView setContentSize:CGSizeMake(0,_heightScrollView.frame.size.height*3)];
        _heightScrollView.delegate = self;
        
        _heightGap = (250.0f - 10.0f)/_heightScrollView.contentSize.height;
        
        [_heightScrollView setContentOffset:CGPointMake(0,(250.0f - _personModel.height)/_heightGap) animated:YES];
        
    }else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailText1CellIdentifier" forIndexPath:indexPath];
        UILabel* titleLabel = (UILabel*)[cell viewWithTag:1];
        UILabel* tLabel = (UILabel*)[cell viewWithTag:2];
        _destStepNumField = (UITextField*)[cell viewWithTag:3];
        _destStepNumField.keyboardType = UIKeyboardTypeNumberPad;
        _destStepNumField.delegate = self;
        
        _destStepNumField.text = [NSString stringWithFormat:@"%ld",(long)_desStepNum];
        
        titleLabel.text = [destStepArray objectAtIndex:0];
        tLabel.text = [destStepArray objectAtIndex:1];
        
    }else if (indexPath.section == 6){
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailDoneCellIdentifier" forIndexPath:indexPath];
        _doneButton = (UIButton*)[cell viewWithTag:1];
        _doneButton.layer.cornerRadius = 4;
        _doneButton.layer.masksToBounds = YES;
        [_doneButton addTarget:self action:@selector(doneButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _nameTextField) {
        if (textField.text.length < 4) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"输入的名字过短" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            textField.text = nil;
            return;
        }
        _personModel.nickName = textField.text;
    }
    if (textField == _ageTextField) {
        if ([textField.text integerValue] <= 0 || [textField.text integerValue] > 120) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"输入的年龄无效" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            textField.text = nil;
            return;
        }
        _personModel.age = [textField.text integerValue];
    }
    if (textField == _destStepNumField) {
        if ([textField.text integerValue] <= 120) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"目标步数过小" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            textField.text = nil;
            return;
        }
        _desStepNum = [textField.text integerValue];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_nameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    [_destStepNumField resignFirstResponder];
    return YES;
}
#pragma mark - ButtonTouch
- (void)sexButtonTouched:(UIButton*)sender
{
    sender.selected = sender.selected?(NO):(YES);
    if (sender == _maleButton) {
        _femaleButton.selected = sender.selected?(NO):(YES);
    }else{
        _maleButton.selected = sender.selected?(NO):(YES);
    }
    _personModel.sex = (_femaleButton.selected)?(2):(1);
}

-(void)doneButtonTouch
{
    BOOL result = YES;
    NSString* warningText = nil;
    if (_personModel.nickName.length == 0) {
        warningText = @"昵称不能为空";
        result = NO;
    }
    if (_desStepNum == 0) {
        warningText = @"目标步数不能为空";
        result = NO;
    }
    if (result == NO) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:warningText delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        
        [ProgressHUD show:@"注册中"];
        [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendPersonInfo:_personModel cmd:ConnectionManagerCommadEnum_SZ_grxx];
    }
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [_nameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    [_destStepNumField resignFirstResponder];
}
#pragma mark - UIScrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_nameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    [_destStepNumField resignFirstResponder];
    
    if (scrollView == _heightScrollView) {
        float heightGap = (250.0f - 10.0f)/_heightScrollView.contentSize.height;
        _heightLabel.text = [NSString stringWithFormat:@"%.f",250.0f - scrollView.contentOffset.y* heightGap];
        _personModel.height = 250.0f - scrollView.contentOffset.y* heightGap;
        
    }else if(scrollView == _weightScrollView){
        float weightGap = (210.0f - 10.0f)/_weightScrollView.contentSize.width;
        _weightLabel.text = [NSString stringWithFormat:@"%.fkg",10.0f + scrollView.contentOffset.x* weightGap];
        _personModel.weight = 10.0f + scrollView.contentOffset.x* weightGap;
    }
}
#pragma mark -
#pragma mark -ConnectionManagerDelegate
- (void) didDiscoverDevice:(oneLedDeviceObject*)device
{
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",@"发现设备:",device.name]];
}
- (void) didDisconnectWithDevice:(oneLedDeviceObject*)device
{
    
}

- (void) didConnectWithDevice:(oneLedDeviceObject*)device
{
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",@"已连接至:",device.name]];
    
    [[ConnectionManager sharedInstance].deviceObject syncCurrentTime:ConnectionManagerCommadEnum_TBSJ];
}
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd{
    if (cmd == ConnectionManagerCommadEnum_SZ_grxx) {
        [ProgressHUD showSuccess:@"个人信息提交成功"];
        [USER_DEFAULT removeObjectForKey:KEY_PersonDest_StepNum];
        [USER_DEFAULT setInteger:_desStepNum forKey:KEY_PersonDest_StepNum];
        [USER_DEFAULT synchronize];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
    }
}
@end

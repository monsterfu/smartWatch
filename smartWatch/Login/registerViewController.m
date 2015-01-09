//
//  registerViewController.m
//  smartWatch
//
//  Created by Monster on 15/1/4.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "registerViewController.h"


@interface registerViewController ()

@end

@implementation registerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _doneButton.layer.cornerRadius = 8;
    _doneButton.layer.masksToBounds = YES;
    
    [ProgressHUD dismiss];
    [ConnectionManager sharedInstance].delegate = self;
    _loginDataIdx = 0;
    _regisierDataIdx = 0;
    [_tableView setEmptyFootView];
    
    _titleArray = @[@"你的小学老师姓什么?",@"你父亲的名字叫什么?",@"你最爱吃什么菜?",@"你高中是在几年几班?"];
    
    NSInteger idex = [USER_DEFAULT integerForKey:KEY_Register_Question];
    _questionIdex = [NSNumber numberWithInteger:idex];
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
    if ([segue.identifier isEqualToString:@"registerDetailIdentifier"]) {
        _registerDetailViewController = (registerDetailViewController*)segue.destinationViewController;
        _registerDetailViewController.personModel = _personModel;
    }
    if ([segue.identifier isEqualToString:@"questionSelectIdentifier"]) {
        _questionSelectViewController = (questionSelectViewController*)segue.destinationViewController;
        _questionSelectViewController.questionIdex = _questionIdex;
        _questionSelectViewController.delegate = self;
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
    }else {
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"usernameCellIdentifier" forIndexPath:indexPath];
            _userNameField = (UITextField*)[cell viewWithTag:2];
            _userNameField.delegate = self;
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"passwordCellIdentifier" forIndexPath:indexPath];
            _passWordField = (UITextField*)[cell viewWithTag:2];
            _passWordField.delegate = self;
            _seePswButton = (UIButton*)[cell viewWithTag:3];
            [_seePswButton addTarget:self action:@selector(seePswButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            _questionCell = [tableView dequeueReusableCellWithIdentifier:@"questionCellIdentifier" forIndexPath:indexPath];
            NSInteger idex = [_questionIdex integerValue];
            _questionLabel = (UILabel*)[_questionCell viewWithTag:2];
            _questionLabel.text = [_titleArray objectAtIndex:idex];
            return _questionCell;
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"answerCellIdentifier" forIndexPath:indexPath];
            _answerField = (UITextField*)[cell viewWithTag:2];
            _answerField.delegate = self;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1&& indexPath.row == 0) {
        [self performSegueWithIdentifier:@"questionSelectIdentifier" sender:_questionIdex];
    }else{
        [self tapAction:nil];
    }
    
}
#pragma mark - questionSelectViewControllerDelegate

-(void)questionSelect:(NSUInteger)row
{
    _questionIdex = [NSNumber numberWithInteger:row];
    _questionLabel.text = [_titleArray objectAtIndex:row];
}

#pragma mark - button touch

- (IBAction)doneButtonTouch:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"registerDetailIdentifier" sender:_personModel];
    return;
    if (_userNameField.text.length < 8) {
        [ProgressHUD showError:@"用户名过短!"];
        return;
    }
    if (_passWordField.text.length <=7)
    {
        [ProgressHUD showError:@"密码长度不得少于8位！"];
        return;
    }
    _personModel.userName = _userNameField.text;
    _personModel.passWord = _passWordField.text;
    _regisierDataIdx = 0;
    [[ConnectionManager sharedInstance].deviceObject sendCommandyhzc_sendRegisterInfoWithPerson:_personModel index:_regisierDataIdx cmd:ConnectionManagerCommadEnum_YHZC_csxx];
    [ProgressHUD show:@"设备注册中，请稍候"];
}
- (void)seePswButtonTouch:(UIButton*)sender
{
    sender.selected = (sender.selected)?(NO):(YES);
    _passWordField.secureTextEntry = !sender.selected;
}
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [_userNameField resignFirstResponder];
    [_passWordField resignFirstResponder];
    [_answerField resignFirstResponder];
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
    if (cmd == ConnectionManagerCommadEnum_YHZC_cswc) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe1&&byteValue[1] == 0x03){
            if (byteValue[2] == 0x03) {
                [ProgressHUD showSuccess:@"设备注册成功,请填写个人信息"];
                [self performSegueWithIdentifier:@"registerDetailIdentifier" sender:_personModel];
//                _loginDataIdx = 0;
//                [[ConnectionManager sharedInstance].deviceObject sendCommandyhdl_sendUserInfoWithPerson:_personModel index:_loginDataIdx cmd:ConnectionManagerCommadEnum_YHDL_fsxx];
            }else{
                [ProgressHUD showError:@"设备注册失败"];
            }
        }
    }
    if (cmd == ConnectionManagerCommadEnum_YHDL_fsxx) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe1&&byteValue[1] == 0x03){
            if (byteValue[2] == 0x05) {
                [ProgressHUD showSuccess:@"登陆成功"];
            }else if (byteValue[2] == 0x06) {
                [ProgressHUD showSuccess:@"用户名错误"];
            }else if (byteValue[2] == 0x07) {
                [ProgressHUD showSuccess:@"密码错误"];
            }
        }
        
    }
    if (cmd == ConnectionManagerCommadEnum_YHZC_sfzc) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe1&&byteValue[1] == 0x03){
            if (byteValue[2] == 0x01) {
                [ProgressHUD show:@"设备已激活，可进行登录"];
                if ([USER_DEFAULT boolForKey:KEY_Auto_Login]) {
                    [[ConnectionManager sharedInstance].deviceObject sendCommandyhdl_sendUserInfoWithPerson:_personModel index:_loginDataIdx cmd:ConnectionManagerCommadEnum_YHDL_fsxx];
                }else{
                    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendDeviceReset:ConnectionManagerCommadEnum_ZZSZ_sbcz];
                }
            }else if (byteValue[2] == 0x02) {
                [ProgressHUD showSuccess:@"设备尚未注册,请进行注册"];
            }
        }
        
    }
    if (cmd == ConnectionManagerCommadEnum_YHDL_fswc) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe1&&byteValue[1] == 0x03){
            if (byteValue[2] == 0x05) {
                [ProgressHUD showSuccess:@"登陆成功"];
            }else if (byteValue[2] == 0x06) {
                [ProgressHUD showSuccess:@"用户名错误"];
            }else if (byteValue[2] == 0x07) {
                [ProgressHUD showSuccess:@"密码错误"];
            }
        }
        
    }
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd{
    if (cmd == ConnectionManagerCommadEnum_YHDL_fsxx) {
        _loginDataIdx ++ ;
        [[ConnectionManager sharedInstance].deviceObject sendCommandyhdl_sendUserInfoWithPerson:_personModel index:_loginDataIdx cmd:ConnectionManagerCommadEnum_YHDL_fsxx];
    }
    if (cmd == ConnectionManagerCommadEnum_YHZC_csxx) {
        _regisierDataIdx ++;
        [[ConnectionManager sharedInstance].deviceObject sendCommandyhzc_sendRegisterInfoWithPerson:_personModel index:_regisierDataIdx cmd:ConnectionManagerCommadEnum_YHZC_csxx];
    }
    if (cmd == ConnectionManagerCommadEnum_TBSJ) {
        [[ConnectionManager sharedInstance].deviceObject sendCommandyhzc_requestDeviceWhetherRegistered:ConnectionManagerCommadEnum_YHZC_sfzc];
    }
    if (cmd == ConnectionManagerCommadEnum_ZZSZ_sbcz) {
        NSLog(@"设备重置");
    }
}
@end

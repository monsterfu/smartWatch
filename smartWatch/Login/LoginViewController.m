//
//  LoginViewController.m
//  smartWatch
//
//  Created by Monster on 15/1/4.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData* aData = [USER_DEFAULT objectForKey:KEY_UserModel_default];
    _personModel = [NSKeyedUnarchiver unarchiveObjectWithData:aData];
    if (_personModel == nil) {
        _personModel = [personInfoModel createWithUserName:nil pw:nil height:165 weight:65 age:22 sex:1];
    }else{
        _userNameField.text = _personModel.userName;
        _passWordField.text = _personModel.passWord;
    }
    
    _sendDataIdx = 0;
    
    [ConnectionManager sharedInstance].delegate = self;
    
    
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
    if ([segue.identifier isEqualToString:@"registerPushIdentifier"]) {
        _registerVController = (registerViewController*)segue.destinationViewController;
        _registerVController.personModel = _personModel;
    }
}


- (IBAction)loginButtonTouch:(UIButton *)sender {
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
    [[ConnectionManager sharedInstance].deviceObject sendCommandyhdl_sendUserInfoWithPerson:_personModel index:_sendDataIdx cmd:ConnectionManagerCommadEnum_YHDL_fsxx];

}

- (IBAction)forgetButtonTouch:(UIButton *)sender {
}

- (IBAction)registerButtonTouch:(UIButton *)sender {
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    [_userNameField resignFirstResponder];
    [_passWordField resignFirstResponder];
}

#pragma mark --
#pragma mark --UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _userNameField)
    {
        if (range.location>10)
        {
            [ProgressHUD showError:@"手机号码只有11位哦!"];
            return  NO;
        }
        else
        {
            return YES;
        }
    }else if(textField == _passWordField){
        
        if(range.location>15){
            [ProgressHUD showError:@"密码输入不能超过15位"];
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
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
                    [[ConnectionManager sharedInstance].deviceObject sendCommandyhdl_sendUserInfoWithPerson:_personModel index:_sendDataIdx cmd:ConnectionManagerCommadEnum_YHDL_fsxx];
                }else{
                    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendDeviceReset:ConnectionManagerCommadEnum_ZZSZ_sbcz];
                }
            }else if (byteValue[2] == 0x02) {
                [ProgressHUD showSuccess:@"设备尚未注册,请进行注册"];
                [self performSegueWithIdentifier:@"registerPushIdentifier" sender:_personModel];
            }
        }
        
    }
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd{
    if (cmd == ConnectionManagerCommadEnum_YHDL_fsxx) {
        _sendDataIdx ++ ;
        [[ConnectionManager sharedInstance].deviceObject sendCommandyhdl_sendUserInfoWithPerson:_personModel index:_sendDataIdx cmd:ConnectionManagerCommadEnum_YHDL_fsxx];
    }
    if (cmd == ConnectionManagerCommadEnum_TBSJ) {
        [[ConnectionManager sharedInstance].deviceObject sendCommandyhzc_requestDeviceWhetherRegistered:ConnectionManagerCommadEnum_YHZC_sfzc];
    }
    if (cmd == ConnectionManagerCommadEnum_ZZSZ_sbcz) {
        NSLog(@"设备重置");
    }
}
@end
//
//  LoginViewController.h
//  smartWatch
//
//  Created by Monster on 15/1/4.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "registerViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,ConnectionManagerDelegate>
{
    NSUInteger _sendDataIdx;
    registerViewController* _registerVController;
    CommonTabbarViewController* _tabbarViewCOntroller;
}

@property(nonatomic, retain)personInfoModel* personModel;
@property(nonatomic, retain)PersonDetaiInfo* personCoreDataInfo;

@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
- (IBAction)loginButtonTouch:(UIButton *)sender;
- (IBAction)forgetButtonTouch:(UIButton *)sender;
- (IBAction)registerButtonTouch:(UIButton *)sender;

- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end

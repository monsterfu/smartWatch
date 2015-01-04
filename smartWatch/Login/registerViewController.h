//
//  registerViewController.h
//  smartWatch
//
//  Created by Monster on 15/1/4.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface registerViewController : UIViewController<UITextFieldDelegate,ConnectionManagerDelegate>
{
    UITextField* _userNameField;
    UITextField* _passWordField;
    UIButton* _seePswButton;
    NSUInteger _regisierDataIdx;
    NSUInteger _loginDataIdx;
}

@property(nonatomic, retain)personInfoModel* personModel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)doneButtonTouch:(UIButton *)sender;

- (IBAction)tapAction:(UITapGestureRecognizer *)sender;



@end

//
//  registerViewController.h
//  smartWatch
//
//  Created by Monster on 15/1/4.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "registerDetailViewController.h"
#import "questionSelectViewController.h"

@interface registerViewController : UIViewController<UITextFieldDelegate,ConnectionManagerDelegate,questionSelectViewControllerDelegate>
{
    UITextField* _userNameField;
    UITextField* _passWordField;
    UITextField* _answerField;
    
    NSArray* _titleArray;
    UIButton* _seePswButton;
    NSUInteger _regisierDataIdx;
    NSUInteger _loginDataIdx;
    
    UITableViewCell* _questionCell;
    UILabel* _questionLabel;
    
    registerDetailViewController* _registerDetailViewController;
    questionSelectViewController* _questionSelectViewController;
}

@property (nonatomic, retain)NSNumber* questionIdex;
@property(nonatomic, retain)personInfoModel* personModel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneButtonTouch:(UIButton *)sender;

- (IBAction)tapAction:(UITapGestureRecognizer *)sender;
- (IBAction)backButtonTouched:(UIBarButtonItem *)sender;



@end

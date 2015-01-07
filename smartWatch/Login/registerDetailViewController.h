//
//  registerDetailViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface registerDetailViewController : UIViewController<UITextFieldDelegate,ConnectionManagerDelegate>
{
    NSArray* nameCellArray;
    NSArray* ageCellArray;
    NSArray* destStepArray;
    
    UITextField* _nameTextField;
    UITextField* _ageTextField;
    UITextField* _destStepNumField;
    
    UIButton* _maleButton;
    UIButton* _femaleButton;
    
    UILabel* _weightLabel;
    UILabel* _heightLabel;
    
    UIScrollView* _weightScrollView;
    UIScrollView* _heightScrollView;
    
    UIImageView* _weightImageView;
    UIImageView* _heightImageView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)tapAction:(UITapGestureRecognizer *)sender;

@end

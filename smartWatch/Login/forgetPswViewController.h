//
//  forgetPswViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-9.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface forgetPswViewController : UIViewController
{
    NSArray* _titleArray;
    
    UILabel* _questionLabel;
    UITextField* _answerTextField;
    UILabel* _passWordLabel;
    UIButton* _confirmButton;
    
    UITapGestureRecognizer* _tapGestureRecognizer;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

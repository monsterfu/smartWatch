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
    
    UITextField* _nameTextField;
    UITextField* _ageTextField;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

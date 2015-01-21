//
//  WeekNumSelectViewController.h
//  smartWatch
//
//  Created by Monster on 15/1/3.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface WeekNumSelectViewController : UIViewController
{
    NSArray* _titleArray;
    NSMutableArray* _valueArray;
}

@property(nonatomic, retain)NSMutableArray* valueArray;//周一至周日的值

- (IBAction)saveButtonTouched:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//
//  SleepListViewController.h
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface SleepListViewController : UIViewController
{
    SleepDataReadingModel* _sleepCoreDataModel;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, retain)NSArray* allsleepsArray;
@end

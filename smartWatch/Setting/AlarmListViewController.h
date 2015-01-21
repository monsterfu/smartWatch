//
//  AlarmListViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-2.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "alarmTableViewCell.h"
#import "AlarmEditViewController.h"


@interface AlarmListViewController : UIViewController<alarmTableViewCellDelegate, ConnectionManagerDelegate, alarmTableViewCellDelegate>
{
    alarmTableViewCell* _alarmCell;
    AlarmModel* _alarmModel;
    NSMutableArray* _alarmArray;
    AlarmEditViewController* _alarmEditViewController;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

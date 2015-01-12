//
//  AlarmEditViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmEditViewController : UIViewController
{
    UITableViewCell* _cell;
}

//editAlarmDateCell  editAlarmRepeatCell  alarmEditRepeatIdentifier
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)doneButtonTouch:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)datePickerChanged:(UIDatePicker *)sender;


@end

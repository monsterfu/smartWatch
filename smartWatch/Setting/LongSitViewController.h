//
//  LongSitViewController.h
//  smartWatch
//
//  Created by Monster on 14-12-30.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "LongSitGapSelectViewController.h"

@interface LongSitViewController : UIViewController<ConnectionManagerDelegate>
{
    UIButton* _startOneButton;
    UIButton* _endOneButton;
    UIButton* _startTwoButton;
    UIButton* _endTwoButton;
    
    UIButton* _selectButton;
    
    BOOL _remindOpen;
    
    UITableViewCell* _gapCell;
    UITableViewCell* _weekNumCell;
    
    LongSitGapSelectViewController* _gapSelectViewController;
    WeekNumSelectViewController* _weekSelectViewController;
}

@property(nonatomic, retain)longSitModel* longsitModelData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
- (IBAction)datePickerChanged:(UIDatePicker *)sender;
- (IBAction)saveButtonTouch:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UISwitch *longsitSwitch;

- (IBAction)enableLongSitSet:(UISwitch *)sender;

@end

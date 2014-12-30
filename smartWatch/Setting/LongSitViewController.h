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

@interface LongSitViewController : UIViewController
{
    UIButton* _startOneButton;
    UIButton* _endOneButton;
    UIButton* _startTwoButton;
    UIButton* _endTwoButton;
    
    UIButton* _selectButton;
    
    NSDate* _startOneDate;
    NSDate* _startTwoDate;
    NSDate* _endOneDate;
    NSDate* _endTwoDate;
    
    LongSitGapSelectViewController* _gapSelectViewController;
}

@property(nonatomic, retain)longSitModel* longsitModelData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
- (IBAction)datePickerChanged:(UIDatePicker *)sender;

@end

//
//  alarmTableViewCell.h
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alarmTableViewCellDelegate <NSObject>
-(void)alarmTableViewCell_SwitchOpen:(BOOL)open tag:(NSUInteger)tag;
@end


@interface alarmTableViewCell : UITableViewCell

@property (nonatomic, weak)id<alarmTableViewCellDelegate>delegate;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchOpen;

- (IBAction)switchOpenChange:(UISwitch *)sender;


@end

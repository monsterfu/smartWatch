//
//  alarmTableViewCell.m
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "alarmTableViewCell.h"

@implementation alarmTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)switchOpenChange:(UISwitch *)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(alarmTableViewCell_SwitchOpen:tag:)]) {
        [self.delegate alarmTableViewCell_SwitchOpen:sender.on tag:self.tag];
    }
}
@end

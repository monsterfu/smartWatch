//
//  visionUpdateCell.m
//  smartWatch
//
//  Created by Monster on 15/1/29.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "visionUpdateCell.h"

@implementation visionUpdateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)updateButtonTouch:(UIButton *)sender {
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(updateButtonTouched)]) {
        [self.delegate updateButtonTouched];
    }
    
}
@end

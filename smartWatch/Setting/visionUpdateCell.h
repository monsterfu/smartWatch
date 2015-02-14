//
//  visionUpdateCell.h
//  smartWatch
//
//  Created by Monster on 15/1/29.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol visionUpdateCellDelegate <NSObject>
-(void)updateButtonTouched;
@end


@interface visionUpdateCell : UITableViewCell

@property(nonatomic, assign)id<visionUpdateCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *updateButton;
- (IBAction)updateButtonTouch:(UIButton *)sender;

@end

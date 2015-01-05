//
//  SportsCircleViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-5.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportsCircleViewController : UIViewController



@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *circleImgView;

//左
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonTouch:(UIButton *)sender;


//右
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
- (IBAction)rightButtonTouch:(UIButton *)sender;

//km
@property (weak, nonatomic) IBOutlet UILabel *kmLabel;

//kcal
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;

//同步
- (IBAction)syncButtonTouch:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *syncTimeLabel;

//下拉更多
- (IBAction)pushMoreButtonTouch:(UIButton *)sender;


@end

//
//  SleepMainViewController.h
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "SleepListViewController.h"

@interface SleepMainViewController : UIViewController<ConnectionManagerDelegate,CPTPlotDataSource>
{
    
    CPTXYGraph *barChart;
    CPTScatterPlot *dataSourceLinePlot;//线
    
    sleepOneDayInfoModel* _sleepModel;
    SleepDataReadingModel* _sleepCoreDataModel;
    NSArray* _allsleepsArray;
    SleepListViewController* _sleepListViewController;
}

@property(nonatomic, retain)PersonDetaiInfo* personInfo;

@property (weak, nonatomic) IBOutlet GradientView *graView;

@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;
- (IBAction)IsRegisterButtonTouch:(UIButton *)sender;
- (IBAction)resetButtonTouch:(UIButton *)sender;

@end

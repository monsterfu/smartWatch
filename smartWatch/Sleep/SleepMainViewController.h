//
//  SleepMainViewController.h
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"


@interface SleepMainViewController : UIViewController<ConnectionManagerDelegate,CPTPlotDataSource>
{
    
    CPTXYGraph *barChart;
    CPTScatterPlot *dataSourceLinePlot;//线
}


@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;
- (IBAction)IsRegisterButtonTouch:(UIButton *)sender;
- (IBAction)resetButtonTouch:(UIButton *)sender;

@end

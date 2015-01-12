//
//  SleepDetailViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface SleepDetailViewController : UIViewController<ConnectionManagerDelegate,CPTPlotDataSource>
{
    
    CPTXYGraph *barChart;
    CPTScatterPlot *dataSourceLinePlot;//线
}

@property (weak, nonatomic) IBOutlet GradientView *graView;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;
@property (weak, nonatomic) IBOutlet UIButton *syncButton;
- (IBAction)syncButtonTouch:(UIButton *)sender;

@end

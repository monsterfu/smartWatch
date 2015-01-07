//
//  SportsDetailViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-5.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface SportsDetailViewController : UIViewController
{
    
    CPTXYGraph *barChart;
    CPTScatterPlot *dataSourceLinePlot;//线
}


@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;

@end

//
//  HeartRateMainViewController.h
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface HeartRateMainViewController : UIViewController<CPTPlotDataSource,UMSocialUIDelegate,CPTBarPlotDelegate>
{
    CPTXYGraph                  *graph;             //画板
    CPTScatterPlot              *dataSourceLinePlot;//线
    int                         j;
    int                         r;
    CPTBorderedLayer * _label;
}



@property (retain, nonatomic) NSMutableArray *dataForPlot1;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;


@end

//
//  SportsMainViewController.h
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface SportsMainViewController : UIViewController<CPTPlotDataSource,UMSocialUIDelegate>
{
    CPTXYGraph                  *graph;             //画板
    CPTScatterPlot              *dataSourceLinePlot;//线
    NSMutableArray              *dataForPlot1;      //坐标数组
    NSTimer                     *timer1;            //定时器
    int                         j;
    int                         r;
    
}
@property (retain, nonatomic) NSMutableArray *dataForPlot1;

- (IBAction)shareTest:(UIBarButtonItem *)sender;


@end

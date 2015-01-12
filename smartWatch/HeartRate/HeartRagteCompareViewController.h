//
//  HeartRagteCompareViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface HeartRagteCompareViewController : UIViewController<CPTPlotDataSource,UMSocialUIDelegate,CPTBarPlotDelegate>
{
    CPTXYGraph                  *graph;             //画板
    CPTScatterPlot              *dataSourceLinePlot;//线
    NSMutableArray              *dataForPlot1;      //坐标数组
    int                         j;
    int                         r;
    CPTBorderedLayer * _label;
    NSMutableArray  * _labelArray;
}

@property (weak, nonatomic) IBOutlet UIView *greenColorView;
@property (weak, nonatomic) IBOutlet UIView *redColorView;

@property (weak, nonatomic) IBOutlet UILabel *dateOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTwoLabel;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;

@end

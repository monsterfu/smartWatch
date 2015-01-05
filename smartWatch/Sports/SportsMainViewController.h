//
//  SportsMainViewController.h
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface SportsMainViewController : UIViewController<CPTPlotDataSource,UMSocialUIDelegate,CPTBarPlotDelegate>
{
    CPTXYGraph                  *graph;             //画板
    CPTScatterPlot              *dataSourceLinePlot;//线
    NSMutableArray              *dataForPlot1;      //坐标数组
    NSTimer                     *timer1;            //定时器
    int                         j;
    int                         r;
    CPTBorderedLayer * _label;
    NSMutableArray  * _labelArray;
}
@property (retain, nonatomic) NSMutableArray *dataForPlot1;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;

//
@property (weak, nonatomic) IBOutlet UILabel *stepNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *kmLabel;
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *midLabel;





- (IBAction)shareTest:(UIBarButtonItem *)sender;


@end

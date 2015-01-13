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
    NSArray* _titleArray;
    CPTXYGraph *barChart;
    CPTScatterPlot *dataSourceLinePlot;//线
}


@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;


@property (weak, nonatomic) IBOutlet UIView *lessView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *highView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

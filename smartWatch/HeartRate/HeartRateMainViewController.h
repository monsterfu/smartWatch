//
//  HeartRateMainViewController.h
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "HeartRateListViewController.h"

@interface HeartRateMainViewController : UIViewController<CPTPlotDataSource,UMSocialUIDelegate,CPTBarPlotDelegate,ConnectionManagerDelegate>
{
    CPTXYGraph                  *graph;             //画板
    CPTScatterPlot              *dataSourceLinePlot;//线
    int                         j;
    int                         r;
    CPTBorderedLayer * _label;
    
    heartRateOneDayInfoModel* _heartRateOneDayModel;
    HeartRateDataReadingModel* _heartRateCoreDataModel;
    NSArray* _allheartRateArray;
    HeartRateListViewController* _heartRateListViewController;
}
@property(nonatomic, retain)PersonDetaiInfo* personInfo;

@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *mixLabel;


@property (retain, nonatomic) NSMutableArray *dataForPlot1;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphHostingView;

- (IBAction)saveButtonTouch:(UIButton *)sender;
- (IBAction)compareButtonTouch:(UIButton *)sender;


- (IBAction)monitorButtonTouch:(UIButton *)sender;


@end

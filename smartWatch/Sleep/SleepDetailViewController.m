//
//  SleepDetailViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "SleepDetailViewController.h"

@interface SleepDetailViewController ()

@end

@implementation SleepDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _personInfo = [PersonDetaiInfo sharedInstance];
    
    [[ConnectionManager sharedInstance]setDelegate:self];
    
    // Do any additional setup after loading the view.
    barChart = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme = [CPTTheme themeNamed:nil];
    [barChart applyTheme:theme];
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)_graphHostingView;
    hostingView.hostedGraph = barChart;
    
    hostingView.layer.cornerRadius = 4;
    hostingView.layer.masksToBounds = YES;
    
    CPTColor *endColor = [[CPTColor alloc]initWithComponentRed:146.0/255.0 green:89.0/255.0 blue:120.0/255.0 alpha:1.0f];
    [barChart setFill:[CPTFill fillWithColor: endColor]];
    // Border
    barChart.plotAreaFrame.borderLineStyle = [CPTLineStyle lineStyle];
    CPTMutableLineStyle* LineStyle = [CPTMutableLineStyle lineStyle];
    LineStyle.lineWidth = 10.0f ;
    LineStyle.lineColor = [CPTColor colorWithGenericGray:0.4];
    barChart.plotAreaFrame.borderLineStyle = nil;
    
    barChart.plotAreaFrame.cornerRadius    = 10.0f;
    barChart.plotAreaFrame.masksToBorder   = YES;
    
    // Paddings
    barChart.paddingLeft   = 0.0f;
    barChart.paddingRight  = 0.0f;
    barChart.paddingTop    = 0.0f;
    barChart.paddingBottom = 0.0f;
    
//    barChart.plotAreaFrame.paddingLeft   = 40.0;
//    barChart.plotAreaFrame.paddingTop    = 40.0;
//    barChart.plotAreaFrame.paddingRight  = 20.0;
//    barChart.plotAreaFrame.paddingBottom = 20.0;
    
    
    // Graph title
    NSString *lineOne = @"Graph Title";
    NSString *lineTwo = @"Line 2";
    
    BOOL hasAttributedStringAdditions = (&NSFontAttributeName != NULL) &&
    (&NSForegroundColorAttributeName != NULL) &&
    (&NSParagraphStyleAttributeName != NULL);
    
    if ( hasAttributedStringAdditions ) {
        NSMutableAttributedString *graphTitle = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", lineOne, lineTwo]];
        [graphTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, lineOne.length)];
        [graphTitle addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(lineOne.length + 1, lineTwo.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = CPTTextAlignmentCenter;
        [graphTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, graphTitle.length)];
        UIFont *titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        [graphTitle addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, lineOne.length)];
        titleFont = [UIFont fontWithName:@"Helvetica" size:12.0];
        [graphTitle addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(lineOne.length + 1, lineTwo.length)];
        
        //        barChart.attributedTitle = graphTitle;
    }
    else {
        CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
        titleStyle.color         = [CPTColor whiteColor];
        titleStyle.fontName      = @"Helvetica-Bold";
        titleStyle.fontSize      = 16.0;
        titleStyle.textAlignment = CPTTextAlignmentCenter;
        
        barChart.title          = [NSString stringWithFormat:@"%@\n%@", lineOne, lineTwo];
        barChart.titleTextStyle = titleStyle;
    }
    
    barChart.titleDisplacement        = CGPointMake(0.0f, -20.0f);
    barChart.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    
    // Add plot space for horizontal bar charts
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)barChart.defaultPlotSpace;
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(300.0f)];
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0f) length:CPTDecimalFromFloat(45.0f)];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)barChart.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromString(@"15");
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    
    CPTMutableLineStyle* majorGridLineStyle = [CPTMutableLineStyle lineStyle ];
    majorGridLineStyle.lineWidth = 0.2f ;
    majorGridLineStyle.lineColor = [CPTColor colorWithGenericGray:0.4];
    x.tickDirection = CPTSignNegative;
    x.majorGridLineStyle = majorGridLineStyle ;
    x.majorTickLength = 0;
    //    x.majorTickLineStyle = [CPTLineStyle lineStyle];
    
    x.axisLineStyle = [CPTLineStyle lineStyle];
    
    NSArray *customTickLocations = [NSArray arrayWithObjects:[NSDecimalNumber numberWithInt:1], [NSDecimalNumber numberWithInt:5], [NSDecimalNumber numberWithInt:10], [NSDecimalNumber numberWithInt:15], nil];
    NSArray *xAxisLabels         = [NSArray arrayWithObjects:@"Label A", @"Label B", @"Label C", @"Label D", @"Label E", nil];
    NSUInteger labelLocation     = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
    for ( NSNumber *tickLocation in customTickLocations ) {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:[xAxisLabels objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
        newLabel.tickLocation = [tickLocation decimalValue];
        //        newLabel.offset       = x.labelOffset + x.majorTickLength;
        //        newLabel.rotation     = M_PI / 4;
        [customLabels addObject:newLabel];
    }
    
    x.axisLabels = [NSSet setWithArray:customLabels];
    
    CPTXYAxis *y = axisSet.yAxis;
    y.axisLineStyle               = nil;
    y.majorTickLineStyle          = nil;
    y.minorTickLineStyle          = nil;
    y.majorIntervalLength         = CPTDecimalFromString(@"50");
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    
    majorGridLineStyle = [CPTMutableLineStyle lineStyle ];
    majorGridLineStyle.lineWidth = 0.2f ;
    majorGridLineStyle.lineColor = [CPTColor colorWithGenericGray:0.4];
    y.tickDirection = CPTSignNegative;
    y.majorGridLineStyle = majorGridLineStyle ;
    y.majorTickLength = 0;
    y.majorTickLineStyle = [CPTLineStyle lineStyle];
    
    
    // First bar plot
    CPTBarPlot *barPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor orangeColor] horizontalBars:NO];
    barPlot.baseValue  = CPTDecimalFromString(@"0");
    barPlot.fill = [CPTFill fillWithColor:[CPTColor colorWithComponentRed:75.0/255 green:193.0/255 blue:210.0/255 alpha:1.0 ]];
    barPlot.dataSource = self;
    
    barPlot.barOffset  = CPTDecimalFromFloat(1.25f);
    barPlot.identifier = @"Bar Plot 1";
    
    CPTMutableLineStyle *lineStyle = [barPlot.lineStyle mutableCopy];
    lineStyle.lineWidth = 1.f;
    lineStyle.lineColor = [CPTColor clearColor];
    barPlot.lineStyle = lineStyle;
    //设置透明实现添加动画
    dataSourceLinePlot.opacity = 0.0f;
    
    [barChart addPlot:barPlot toPlotSpace:plotSpace];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - rega

-( void )applyThemeToBackground:(CPTXYGraph *)graph
{
    CPTColor *endColor = [[CPTColor alloc]initWithComponentRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1.0f];
    graph.fill = [CPTFill fillWithColor: endColor];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 5;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSDecimalNumber *num = nil;
    
    if ( [plot isKindOfClass:[CPTBarPlot class]] ) {
        switch ( fieldEnum ) {
            case CPTBarPlotFieldBarLocation:
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index*4];
                break;
                
            case CPTBarPlotFieldBarTip:
                num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:(index + 12) * (index + 12)];
                if ( [plot.identifier isEqual:@"Bar Plot 2"] ) {
                    num = [num decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"10"]];
                }
                break;
        }
    }
    
    return num;
}
- (IBAction)syncButtonTouch:(UIButton *)sender {
    [ProgressHUD show:@"同步中"];
    [[ConnectionManager sharedInstance].deviceObject sendCommandsmxx_requestHistoryInfo:ConnectionManagerCommadEnum_SM_lsjl];
}

#pragma mark -ConnectionManagerDelegate
- (void) didDiscoverDevice:(oneLedDeviceObject*)device
{
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",@"发现设备:",device.name]];
}
- (void) didDisconnectWithDevice:(oneLedDeviceObject*)device
{
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",@"断开连接:",device.name]];
}
- (void) didConnectWithDevice:(oneLedDeviceObject*)device
{
    
}
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SM_lsjl) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe3&&byteValue[1] == 0x12){
            _sleepModel = [[sleepOneDayInfoModel alloc]initWithData:data];
            [_personInfo addSleepReadingWithModel:_sleepModel];
            [[ConnectionManager sharedInstance].deviceObject sendCommandsmxx_requestPerAck:ConnectionManagerCommadEnum_ACK];
        }else if (byteValue[0] == 0xe3&&byteValue[1] == 0x02) {
            [ProgressHUD showSuccess:@"同步完成"];
            [[ConnectionManager sharedInstance].deviceObject sendCommandsmxx_requestPerAck:ConnectionManagerCommadEnum_SM_lsjl];
        }
        
    }
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd{
    
}
@end

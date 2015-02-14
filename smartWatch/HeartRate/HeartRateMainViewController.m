//
//  HeartRateMainViewController.m
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "HeartRateMainViewController.h"

@interface HeartRateMainViewController ()

@end

@implementation HeartRateMainViewController

- (void)viewDidAppear:(BOOL)animated
{
    CommonNavigationController* _navigationController = (CommonNavigationController*)self.tabBarController.navigationController;
    [_navigationController setNavigationBartintColor:[UIColor getColor:@"46a719"]];
    
    [ConnectionManager sharedInstance].delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ProgressHUD show:@"同步中..."];
    [[ConnectionManager sharedInstance].deviceObject sendCommandxlxx_requestHistoryInfo:ConnectionManagerCommadEnum_SL_lsjl];
    [ConnectionManager sharedInstance].delegate = self;
    _personInfo = [PersonDetaiInfo sharedInstance];
    
    graph  = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    
    //给画板添加一个主题
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph applyTheme:theme];
    
    //创建主画板视图添加画板
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)_graphHostingView;
    hostingView.hostedGraph = graph;
    hostingView.backgroundColor = [UIColor getColor:@"dbdbdb"];
    [self.view addSubview:hostingView];
    
    graph.plotAreaFrame.borderLineStyle = nil;
    graph.plotAreaFrame.cornerRadius    = 0.0f;
    graph.plotAreaFrame.masksToBorder   = NO;
    
    //设置留白
    graph.paddingLeft = 0;
    graph.paddingTop = 0;
    graph.paddingRight = 0;
    graph.paddingBottom = 0;
    
    graph.plotAreaFrame.paddingLeft = 45.0 ;
    graph.plotAreaFrame.paddingTop = 40.0 ;
    graph.plotAreaFrame.paddingRight = 30.0 ;
    graph.plotAreaFrame.paddingBottom = 50.0 ;
    
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = NO;
    
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(200.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(200.0)];
    
    
    //设置坐标刻度大小
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) graph.axisSet ;
    CPTXYAxis *x = axisSet.xAxis ;
    x.axisLineStyle               = nil;
    x.majorTickLineStyle          = nil;
    x.minorTickLineStyle          = nil;
    // 大刻度线间距： 50 单位
    x. majorIntervalLength = CPTDecimalFromString (@"50");
    // 坐标原点： 0
    x. orthogonalCoordinateDecimal = CPTDecimalFromString ( @"0" );
    
    CPTXYAxis *y = axisSet.yAxis ;
    y.axisLineStyle               = nil;
    y.majorTickLineStyle          = nil;
    y.minorTickLineStyle          = nil;
    y.majorIntervalLength         = CPTDecimalFromString(@"50");
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle ];
    majorGridLineStyle.lineWidth = 0.2f ;
    majorGridLineStyle.lineColor = [CPTColor colorWithGenericGray:0.4];
    // 轴标签方向： CPSignNone －无，同 CPSignNegative ， CPSignPositive －反向 , 在 y 轴的右边， CPSignNegative －正向，在 y 轴的左边
    y.tickDirection = CPTSignNegative;
    y.majorGridLineStyle = majorGridLineStyle ;
    y.majorTickLength = 0;
    y.majorTickLineStyle = [CPTLineStyle lineStyle];
    
    //创建绿色线
    dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    dataSourceLinePlot.identifier = @"Green Plot";
    dataSourceLinePlot.delegate = self;
    //设置绿色区域边框的样式
    CPTMutableLineStyle *lineStyle = [dataSourceLinePlot.dataLineStyle mutableCopy];
    lineStyle.lineWidth = 1.f;
    lineStyle.lineColor = [CPTColor greenColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    //设置透明实现添加动画
    dataSourceLinePlot.opacity = 0.0f;
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor greenColor];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor whiteColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(5.0, 5.0);
    dataSourceLinePlot.plotSymbol = plotSymbol;
    
    //设置数据元代理
    dataSourceLinePlot.dataSource = self;
    [graph addPlot:dataSourceLinePlot];
    
    // 创建一个颜色渐变：从 建变色 1 渐变到 无色
    CPTGradient *areaGradient = [ CPTGradient gradientWithBeginningColor :[CPTColor colorWithComponentRed:0.0f green:1.0f blue:0.0f alpha:0.2] endingColor :[CPTColor colorWithComponentRed:0.0f green:1.0f blue:0.0f alpha:0.2]];
    // 渐变角度： -90 度（顺时针旋转）
    areaGradient.angle = 90.0f ;
    // 创建一个颜色填充：以颜色渐变进行填充
    CPTFill *areaGradientFill = [ CPTFill fillWithGradient :areaGradient];
    // 为图形设置渐变区
    dataSourceLinePlot. areaFill = areaGradientFill;
    dataSourceLinePlot. areaBaseValue = CPTDecimalFromString ( @"0.0" );
    dataSourceLinePlot.interpolation = CPTScatterPlotInterpolationLinear ;
    
    
    _dataForPlot1 = [[NSMutableArray alloc] init];
    j = 200;
    r = 0;
    //    timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dataOpt) userInfo:nil repeats:YES];
    //    [timer1 fire];
    for (NSInteger index = 0; index < 10; index ++) {
        NSString *xp = [NSString stringWithFormat:@"%d",j];
        NSString *yp = [NSString stringWithFormat:@"%d",(rand()%100 + rand()%100)];
        NSMutableDictionary *point1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:xp, @"x", yp, @"y", nil];
        [_dataForPlot1 insertObject:point1 atIndex:0];
        j = j + 20;
        r = r + 20;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - dataSourceOpt
#if 1
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [_dataForPlot1 count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber *num;
    //让视图偏移
    if ( [(NSString *)plot.identifier isEqualToString:@"Green Plot"] ) {
        num = [[_dataForPlot1 objectAtIndex:index] valueForKey:key];
        if ( fieldEnum == CPTScatterPlotFieldX ) {
            num = [NSNumber numberWithDouble:[num doubleValue] - r];
        }
    }
    //添加动画效果
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.duration = 1.0f;
    fadeInAnimation.removedOnCompletion = NO;
    fadeInAnimation.fillMode = kCAFillModeForwards;
    fadeInAnimation.toValue = [NSNumber numberWithFloat:2.0];
    [dataSourceLinePlot addAnimation:fadeInAnimation forKey:@"animateOpacity"];
    return num;
}
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    //    NSNumber* num=[[dataForPlot1 objectAtIndex:index] valueForKey:@"y"];
    
    NSLog(@"dataLabelForPlot  position: %f, %f",plot.position.x, plot.position.y);
    
    _label = [[CPTBorderedLayer alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [_label setFill:[CPTFill fillWithColor:[CPTColor colorWithGenericGray:0.5]]];
    //    UIView* detailView = [[UIView alloc]initWithFrame:_label.frame];
    //    UIImage *loadImage=[UIImage imageNamed:@"popup@2x.png"];
    //    UIImageView* img = [[UIImageView alloc]initWithImage:loadImage];
    //    [detailView addSubview:img];
    //    [_label addSublayer:detailView.layer];
    //    CGImageRef cgimage=loadImage.CGImage;
    //    [_label setFill:[CPTFill fillWithImage:[CPTImage imageWithCGImage:cgimage]]];
    //    _label.anchorPoint = CGPointMake(0, 0);
    //    [_labelArray addObject:_label];
    return _label;
}

-(void)plot:(CPTPlot *)plot dataLabelWasSelectedAtRecordIndex:(NSUInteger)idx
{
    NSNumber* y=[[_dataForPlot1 objectAtIndex:idx] valueForKey:@"y"];
    NSNumber* x=[[_dataForPlot1 objectAtIndex:idx] valueForKey:@"x"];
    
//    NSLog(@"%lu dataLabelWasSelected!  position: %f, %f",(unsigned long)idx,[x floatValue]-r, [y floatValue]);
//    [_customerView removeFromSuperview];
//    [_customerView setFrame:CGRectMake([x floatValue]-r, [y floatValue], _customerView.frame.size.width, _customerView.frame.size.height)];
    //    [_graphHostingView addSubview:_customerView];
    
}
#endif
- (IBAction)saveButtonTouch:(UIButton *)sender {
    [self performSegueWithIdentifier:@"heartRateListIdentifier" sender:nil];
}

- (IBAction)compareButtonTouch:(UIButton *)sender {
}

- (IBAction)monitorButtonTouch:(UIButton *)sender {
}

#pragma mark -ConnectionManagerDelegate
- (void) didDisconnectWithDevice:(oneLedDeviceObject*)device
{
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",@"断开连接:",device.name]];
}
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SL_lsjl) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe4&&byteValue[1] == 0x12){
            _heartRateOneDayModel = [[heartRateOneDayInfoModel alloc]initWithData:data];
            [_personInfo addHeartRateReadingWithModel:_heartRateOneDayModel];
            [[ConnectionManager sharedInstance].deviceObject sendCommandxlxx_requestPerAck:ConnectionManagerCommadEnum_SL_lsjl];
        }else if (byteValue[0] == 0xe4&&byteValue[1] == 0x02) {
            [ProgressHUD showSuccess:@"同步完成"];
            [[ConnectionManager sharedInstance].deviceObject sendCommandxlxx_requestPerAck:ConnectionManagerCommadEnum_SL_lsjl];
            [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_SaveSyncData object:nil];
            _allheartRateArray = [NSArray array];
            _allheartRateArray = [_personInfo allHeartRates];
            if ([_allheartRateArray count]) {
                _heartRateCoreDataModel = [_allheartRateArray objectAtIndex:0];
            }else{
                _heartRateCoreDataModel = nil;
            }
            //            _dateLabel.text = [_sleepCoreDataModel.date formatString:NSDateFormatString_2];
            //            _stepNumLabel.text = [NSString stringWithFormat:@"%ld",_sportCoreDataModel.totalStepNum.longValue];
            //            _kmLabel.text = [NSString stringWithFormat:@"%.1f",_sportCoreDataModel.distance.longValue/1000.0f];
            //            _kcalLabel.text = [NSString stringWithFormat:@"%ld",_sportCoreDataModel.totalKcal.longValue];
        }
        
    }
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd{
    
}
@end

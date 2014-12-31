//
//  heartRateOneDayInfoModel.h
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    heartRateOneDayModeEnum_Test,           //测试模式
    heartRateOneDayModeEnum_Minitor,        //监控模式
} heartRateOneDayModeEnum;


@interface heartRateOneDayInfoModel : NSObject

@property(nonatomic,assign)heartRateOneDayModeEnum mode;
@property(nonatomic,assign)long secTotal;
@property(nonatomic,assign)long rateVale;           //心率值

-(heartRateOneDayInfoModel*)initWithData:(NSData*)data;
@end

//
//  sleepOneDayInfoModel.h
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sleepOneDayInfoModel : NSObject


@property(nonatomic, assign)long sec;           //时间戳   4字节
@property(nonatomic, assign)long totalTime;     //睡眠总时间  3字节
@property(nonatomic, assign)long inSleepTime;   //睡着时间  2字节
@property(nonatomic, assign)long moveTime;      //活动时间  2字节
@property(nonatomic, assign)long wakeUpTime;    //睡醒次数

-(sleepOneDayInfoModel*)initWithData:(NSData*)data;

@end

//
//  SleepDataReadingModel.m
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "SleepDataReadingModel.h"
#import "PersonDetaiInfo.h"


@implementation SleepDataReadingModel

@dynamic time;
@dynamic totalSleepTime;
@dynamic inSleepTime;
@dynamic activeTime;
@dynamic wakeUpNum;
@dynamic personSleep;

-(NSString*)sleepTotalStr
{
    NSString* str = nil;
    double hour = [self.totalSleepTime doubleValue]/60/60;
    double min = [self.totalSleepTime integerValue]/60%60;
    if (hour > 0) {
        str = [NSString stringWithFormat:@"%f小时%2f分",hour, min];
    }else{
        str = [NSString stringWithFormat:@"%2f分", min];
    }
    
    return str;
}


-(NSString*)sleepInPercentStr
{
    NSString* str = nil;
    double totalSleep = [self.inSleepTime doubleValue];
    double insleep = [self.totalSleepTime doubleValue];
    if (totalSleep == 0 || insleep == 0) {
        str = [NSString stringWithFormat:@"0%%"];
    }else{
        float insle = (insleep/totalSleep)*100;
        str = [NSString stringWithFormat:@"%.1f%%",insle];
    }
    return str;
}
-(NSString*)activePercentStr
{
    NSString* str = nil;
    double totalSleep = [self.inSleepTime doubleValue];
    double active = [self.activeTime doubleValue];
    if (totalSleep == 0 || active == 0) {
        str = [NSString stringWithFormat:@"0%%"];
    }else{
        float insle = (active/totalSleep)*100;
        str = [NSString stringWithFormat:@"%.1f%%",insle];
    }
    return str;
}
@end

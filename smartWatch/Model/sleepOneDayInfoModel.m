//
//  sleepOneDayInfoModel.m
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "sleepOneDayInfoModel.h"

/**
 *  格式:     F2 + 时间戳 + 睡眠总时间 + 睡着时间 + 活动时间 + 睡醒次数 +CRC16
 *  字节数:    1 字节 4 字节 3 字节 2 字节 2 字节 2 字节 2 字节
 *  单位:     秒 秒 分 分 次
 */
@implementation sleepOneDayInfoModel


- (sleepOneDayInfoModel*)initWithData:(NSData*)data
{
    if (self = [super init])
    {
        NSUInteger index = 0;
        if (data == nil) {
            return self;
        }
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[index] == 0xf2&&data.length == 16) {
            index ++;
            _sec = byteValue[index]* 1000 + byteValue[index+1]*100 + byteValue[index+2]*10 + byteValue[index+3];
            index += 4;
            _totalTime = byteValue[index]*100 + byteValue[index+1]*10 + byteValue[index+2];
            index += 3;
            _inSleepTime = byteValue[index]*10 + byteValue[index+1];
            index += 2;
            _moveTime = byteValue[index]*10 + byteValue[index+1];
            index += 2;
            _wakeUpTime = byteValue[index]*10 + byteValue[index+1];
        }
    }
    return self;
    
}
@end

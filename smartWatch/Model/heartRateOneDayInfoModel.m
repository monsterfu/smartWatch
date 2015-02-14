//
//  heartRateOneDayInfoModel.m
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "heartRateOneDayInfoModel.h"

/**
 *  【1】 测试模式
 格式: 字节数: 单位:
 【2】 监控模式 格式:
 字节数:
 F3 + 时间戳 +心率值 + CRC16 1 字节 4 字节 1 字节 2 字节
 秒 BPM
 F4 + 时间戳 +心率值 + CRC16 1 字节 4 字节 1 字节 2 字节
 单位: 秒 BPM
 */

@implementation heartRateOneDayInfoModel


-(heartRateOneDayInfoModel*)initWithData:(NSData*)data
{
    if (self = [super init])
    {
        NSUInteger index = 0;
        if (data == nil) {
            return self;
        }
        Byte* byteValue = (Byte*)data.bytes;
        if (data.length == 8) {
            if (byteValue[index] == 0xf3) {
                _mode = heartRateOneDayModeEnum_Test;
            }else if (byteValue[index] == 0xf4){
                _mode = heartRateOneDayModeEnum_Minitor;
            }
            index +=1;
            _secTotal = byteValue[index] + byteValue[index+1]*10 + byteValue[index+2]*100 + byteValue[index+3]* 1000;
            index += 4;
            _rateVale = byteValue[index];
        }
    }
    return self;
}
@end

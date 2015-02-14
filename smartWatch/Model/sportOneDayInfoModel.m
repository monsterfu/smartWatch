//
//  sportOneDayInfoModel.m
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "sportOneDayInfoModel.h"
#import "GlobalHeader.h"

/**
 *  格式: F1 + 日期 + 总步数 + 运动距离 + 卡路里总消耗 + 运动卡路里消耗 
    字节数:
        1字节  3字节  3字节    3字节        2字节       2字节
 单位:        天       步       M          Kcal        Kcal
 (NOTE: 日期分别对应 年 月 日 BCD码, 如: 140616代表2014年6月16日)
 + CRC16 2 字节
 */


@implementation sportOneDayInfoModel

- (sportOneDayInfoModel*)initWithData:(NSData*)data
{
    if (self = [super init])
    {
        NSUInteger index = 2;
        if (data == nil) {
            return self;
        }//<e212f120 01212001 00e50000 48001000 f05bdce3>
         //<e212f120 01213818 000a1600 4f03af01 0f07782e>
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[index] == 0xf1&&data.length == 20) {
            index +=1;
            NSLog(@"byteValue[index]:%d, %d",byteValue[index+2],BCD_TO_TEN(byteValue[index+2]));
            
            NSUInteger year = 2000 + BCD_TO_TEN(byteValue[index]);
            NSUInteger month = BCD_TO_TEN(byteValue[index+1]);
            NSUInteger day = BCD_TO_TEN(byteValue[index+2]);
            
            NSDateComponents *comps = [[NSDateComponents alloc]init];
            [comps setMonth:month];
            [comps setDay:day];
            [comps setYear:year];
            NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            _date = [calendar dateFromComponents:comps];
            index += 3;
            _stepCount = byteValue[index] + byteValue[index+1]*10 + byteValue[index+2]*100;
            index += 3;
            _distance = byteValue[index] + byteValue[index+1]*10 + byteValue[index+2]*100;
            index += 3;
            _totalCalories = byteValue[index] + byteValue[index+1]*10;
            index += 2;
            _sportCalories = byteValue[index] + byteValue[index+1]*10;
            
        }
    }
    return self;

}

@end

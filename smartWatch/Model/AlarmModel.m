//
//  AlarmModel.m
//  smartWatch
//
//  Created by Monster on 14-12-29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "AlarmModel.h"
#import "GlobalHeader.h"

@implementation AlarmModel

-(char)createInfo
{
    char val = 0x00;
    for (NSUInteger index = 0; index < _valueArray.count; index ++) {
        if ([[_valueArray objectAtIndex:index] boolValue]) {
            val |= (1<< index);
        }
    }
    if (_enable) {
        val |= (1<< 7);
    }
    return val;
}

-(NSString*)repeatDetailString
{
    NSString* str = @" ";
    BOOL one,two,three,four,five,six,seven;
    one = two = three = four = five = six = seven = NO;
    
    if ([[_valueArray objectAtIndex:0] boolValue]) {
        str = [str stringByAppendingString:@"周一"];
        one = YES;
    }
    if ([[_valueArray objectAtIndex:1] boolValue]) {
        str = [str stringByAppendingString:@"周二"];
        two = YES;
    }
    if ([[_valueArray objectAtIndex:2] boolValue]) {
        str = [str stringByAppendingString:@"周三"];
        three = YES;
    }
    if ([[_valueArray objectAtIndex:3] boolValue]) {
        str = [str stringByAppendingString:@"周四"];
        four = YES;
    }
    if ([[_valueArray objectAtIndex:4] boolValue]) {
        str = [str stringByAppendingString:@"周五"];
        five = YES;
    }
    if ([[_valueArray objectAtIndex:5] boolValue]) {
        str = [str stringByAppendingString:@"周六"];
        six = YES;
    }
    if ([[_valueArray objectAtIndex:6] boolValue]) {
        str = [str stringByAppendingString:@"周日"];
        seven = YES;
    }
    if (one&&two&&three&&four&&five&&six&&seven) {
        return @"每天";
    }
    if (one&&two&&three&&four&&five&&!six&&!seven) {
        return @"工作日";
    }
    if (!one&&!two&&!three&&!four&&!five&&six&&seven) {
        str = @"周末";
    }
    return str;
}
-(NSString*)timeDetailString
{
    return [NSString stringWithFormat:@"%02d:%02d",_hour,_min];
}
//int a=10;
//int b=a;
//b=b>>（3-1）&1;

- (AlarmModel*)initWithData:(NSData*)data
{
    if (self = [super init])
    {
        NSUInteger index = 0;
        _valueArray = [NSMutableArray array];
        if (data == nil) {
            for (NSUInteger x = 0; x < 8; x++) {
                [_valueArray addObject:[NSNumber numberWithBool:NO]];
            }
            return self;
        }
        Byte* byteValue = (Byte*)data.bytes;
        for (NSUInteger x = 1; x < 9; x++) {
            NSUInteger b = 0;
            b=byteValue[index]>>(x-1)&1;
            if (x == 8) {
                _enable = ((b == 0)?(NO):(YES));
            }else{
                [_valueArray addObject:[NSNumber numberWithBool:((b == 0)?(NO):(YES))]];
            }
        }
        index ++;
        _hour = BCD_TO_TEN(byteValue[index]);
        _min = BCD_TO_TEN(byteValue[index+1]);
    }
    return self;
}
@end

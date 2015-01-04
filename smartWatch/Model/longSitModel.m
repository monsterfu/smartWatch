//
//  longSitModel.m
//  smartWatch
//
//  Created by Monster on 14/12/29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "longSitModel.h"
#import "GlobalHeader.h"

@implementation longSitModel

-(char)createInfo
{
    char val = 0x00;
    for (NSUInteger index = 0; index < _valueArray.count; index ++) {
        if ([[_valueArray objectAtIndex:index] boolValue]) {
            val |= (1<< index);
        }
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
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_startDate1 forKey:KEY_LONGSIT_STARTDATE1];
    [aCoder encodeObject:_startDate2 forKey:KEY_LONGSIT_STARTDATE2];
    [aCoder encodeObject:_endDate1 forKey:KEY_LONGSIT_ENDDATE1];
    [aCoder encodeObject:_endDate2 forKey:KEY_LONGSIT_ENDDATE2];
    [aCoder encodeInteger:_remindGap forKey:KEY_longSitRemindGap];
    [aCoder encodeBool:_open forKey:KEY_longSitRemindOpen];
    [aCoder encodeObject:_valueArray forKey:KEY_longSitRemindWeekNum];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        _startDate1  = [aDecoder decodeObjectForKey:KEY_LONGSIT_STARTDATE1];
        _startDate2  = [aDecoder decodeObjectForKey:KEY_LONGSIT_STARTDATE2];
        _endDate1  = [aDecoder decodeObjectForKey:KEY_LONGSIT_ENDDATE1];
        _endDate2  = [aDecoder decodeObjectForKey:KEY_LONGSIT_ENDDATE2];
        _open  = [aDecoder decodeBoolForKey:KEY_longSitRemindOpen];
        _remindGap = [aDecoder decodeIntegerForKey:KEY_longSitRemindGap];
        _valueArray = [aDecoder decodeObjectForKey:KEY_longSitRemindWeekNum];
    }
    return self;
}
@end

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
    return val;
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

//
//  NSString+longTimeGapIndex.m
//  smartWatch
//
//  Created by Monster on 14-12-30.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "NSString+longTimeGapIndex.h"

@implementation NSString (longTimeGapIndex)

+(NSString*)longTimeGapIndex:(longSitRemindGapEnum_Enum)gapEnum
{
    switch (gapEnum) {
        case longSitRemindGapEnum_15:
            return @"15分钟";
            break;
        case longSitRemindGapEnum_30:
            return @"30分钟";
            break;
        case longSitRemindGapEnum_45:
            return @"45分钟";
            break;
        case longSitRemindGapEnum_60:
            return @"60分钟";
            break;
            
        default:
            return @"15分钟";
            break;
    }
}
@end

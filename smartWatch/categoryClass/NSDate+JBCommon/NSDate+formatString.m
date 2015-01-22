//
//  NSDate+formatString.m
//  smartWatch
//
//  Created by Monster on 15/1/22.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "NSDate+formatString.h"

@implementation NSDate (formatString)


-(NSString*)formatString:(NSDateFormatString_Enum)type
{
    NSString* str = nil;
    switch (type) {
        case NSDateFormatString_1:
        {
            str = [NSString stringWithFormat:@"%lu/%02lu/%02lu",(unsigned long)self.year,(unsigned long)self.month,(unsigned long)self.day];
        }
            break;
        case NSDateFormatString_2:
        {
            str = [NSString stringWithFormat:@"%lu年%02lu月%02lu日",(unsigned long)self.year,(unsigned long)self.month,(unsigned long)self.day];
        }
            break;
        default:
            break;
    }
    return str;
}
@end

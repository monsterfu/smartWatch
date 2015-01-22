//
//  NSDate+formatString.h
//  smartWatch
//
//  Created by Monster on 15/1/22.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDate+JBCommon.h"

typedef enum : NSUInteger {
    NSDateFormatString_1,       //2014/02/18
    NSDateFormatString_2,       //2014年02月18日
    NSDateFormatString_None,
} NSDateFormatString_Enum;

@interface NSDate (formatString)

-(NSString*)formatString:(NSDateFormatString_Enum)type;

@end

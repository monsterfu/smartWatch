//
//  NSString+longTimeGapIndex.h
//  smartWatch
//
//  Created by Monster on 14-12-30.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "longSitModel.h"

@interface NSString (longTimeGapIndex)

+(NSString*)longTimeGapIndex:(longSitRemindGapEnum_Enum)gapEnum;

@end

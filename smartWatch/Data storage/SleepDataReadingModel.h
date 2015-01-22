//
//  SleepDataReadingModel.h
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonDetaiInfo;

@interface SleepDataReadingModel : NSManagedObject

@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSNumber * totalSleepTime;
@property (nonatomic, retain) NSNumber * inSleepTime;
@property (nonatomic, retain) NSNumber * activeTime;
@property (nonatomic, retain) NSNumber * wakeUpNum;
@property (nonatomic, retain) PersonDetaiInfo *personSleep;

-(NSString*)sleepTotalStr;
-(NSString*)sleepInPercentStr;
-(NSString*)activePercentStr;
@end

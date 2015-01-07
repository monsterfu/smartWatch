//
//  HeartRateDataReadingModel.h
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonDetaiInfo;

@interface HeartRateDataReadingModel : NSManagedObject

@property (nonatomic, retain) NSNumber * mode;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSNumber * heartRate;
@property (nonatomic, retain) PersonDetaiInfo *personHeartRate;

@end

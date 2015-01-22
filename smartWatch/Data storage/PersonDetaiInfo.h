//
//  PersonDetaiInfo.h
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "personInfoModel.h"
#import "sportOneDayInfoModel.h"
#import "sleepOneDayInfoModel.h"
#import "heartRateOneDayInfoModel.h"
#import "SportDataReadingModel.h"
#import "SleepDataReadingModel.h"
#import "HeartRateDataReadingModel.h"



@interface PersonDetaiInfo : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * nickName;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * heightUnit;
@property (nonatomic, retain) NSNumber * weightUnit;
@property (nonatomic, retain) NSNumber * lengthUnit;
@property (nonatomic, retain) NSSet *sport;
@property (nonatomic, retain) NSSet *heartRate;
@property (nonatomic, retain) NSSet *sleep;


+(PersonDetaiInfo*) sharedInstance;
+(PersonDetaiInfo *) CreateWithPersonModel:(personInfoModel*)model;
//+ (NSArray *) findPersonWithUserName:(NSString*)name;
+ (NSMutableArray *) allPersonDetail;
//
- (BOOL)addSportReadingWithModel:(sportOneDayInfoModel*)model;
- (BOOL)addSleepReadingWithModel:(sleepOneDayInfoModel*)model;
- (BOOL)addHeartRateReadingWithModel:(heartRateOneDayInfoModel*)model;
//
- (SportDataReadingModel *) findSportsWithDate:(NSDate*)date;
- (SleepDataReadingModel *) findSleepsWithDate:(NSDate*)date;
- (HeartRateDataReadingModel *) findHeartRatesWithDate:(NSDate*)date;

//
- (NSArray *) allSports;
- (NSArray *) allSleeps;
- (NSArray *) allHeartRates;
@end

@interface PersonDetaiInfo (CoreDataGeneratedAccessors)

- (void)addSportObject:(SportDataReadingModel *)value;
- (void)removeSportObject:(SportDataReadingModel *)value;
- (void)addSport:(NSSet *)values;
- (void)removeSport:(NSSet *)values;

- (void)addHeartRateObject:(HeartRateDataReadingModel *)value;
- (void)removeHeartRateObject:(HeartRateDataReadingModel *)value;
- (void)addHeartRate:(NSSet *)values;
- (void)removeHeartRate:(NSSet *)values;

- (void)addSleepObject:(SleepDataReadingModel *)value;
- (void)removeSleepObject:(SleepDataReadingModel *)value;
- (void)addSleep:(NSSet *)values;
- (void)removeSleep:(NSSet *)values;

@end

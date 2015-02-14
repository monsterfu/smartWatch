//
//  PersonDetaiInfo.m
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "PersonDetaiInfo.h"
#import "HeartRateDataReadingModel.h"
#import "SleepDataReadingModel.h"
#import "SportDataReadingModel.h"
#import "AppDelegate.h"


@implementation PersonDetaiInfo

@dynamic age;
@dynamic height;
@dynamic nickName;
@dynamic sex;
@dynamic weight;
@dynamic userName;
@dynamic password;
@dynamic heightUnit;
@dynamic weightUnit;
@dynamic lengthUnit;
@dynamic sport;
@dynamic heartRate;
@dynamic sleep;
#pragma mark - create
static PersonDetaiInfo *sharedConnectionManager = nil;

+ (PersonDetaiInfo*) sharedInstance
{
    if (sharedConnectionManager == nil)
    {
        if ([PersonDetaiInfo allPersonDetail].count > 0) {
           sharedConnectionManager = [[PersonDetaiInfo allPersonDetail]objectAtIndex:0];
        }
        
    }
    return sharedConnectionManager;
}

+(PersonDetaiInfo *) CreateWithPersonModel:(personInfoModel*)model
{
    NSManagedObjectContext *managedObjectContext = [(AppDelegate*) [[UIApplication sharedApplication] delegate] managedObjectContext];
    
    PersonDetaiInfo *personDetailInfo = (PersonDetaiInfo *) [NSEntityDescription insertNewObjectForEntityForName:@"PersonDetaiInfo" inManagedObjectContext:managedObjectContext];
    personDetailInfo.userName = model.userName;
    personDetailInfo.password = model.passWord;
    personDetailInfo.height = [NSNumber numberWithInteger:model.height];
    personDetailInfo.weight = [NSNumber numberWithInteger:model.weight];
    personDetailInfo.age = [NSNumber numberWithInteger:model.age];
    personDetailInfo.sex = [NSNumber numberWithInteger:model.sex];
    return personDetailInfo;
}

+ (NSMutableArray *) allPersonDetail
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSError *error;
    NSArray *array = [delegate.managedObjectContext executeFetchRequest:[delegate.managedObjectModel fetchRequestTemplateForName:@"personFetchRequest"] error:&error];
    if (error)
    {
        NSLog(@"Fetching stored fobs failed. Error: %@", error);
    }
    return [NSMutableArray arrayWithArray:array];
}

//+ (NSArray *) findPersonWithUserName:(NSString*)name
//{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"personFetchRequest"];
//    NSError *error;
//    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
//    if (error)
//    {
//        NSLog(@"Fetching readings failed: %@", error);
//    }
//    return array;
//}

#pragma mark - add
- (BOOL) addSportReadingWithModel:(sportOneDayInfoModel *)model
{
    SportDataReadingModel *reading = (SportDataReadingModel *) [NSEntityDescription insertNewObjectForEntityForName:@"SportDataReadingModel" inManagedObjectContext:self.managedObjectContext];
    
    [reading setDate:model.date];
    [reading setDistance:[NSNumber numberWithUnsignedInteger:model.distance]];
    [reading setTotalKcal:[NSNumber numberWithUnsignedInteger:model.totalCalories]];
    [reading setKcal:[NSNumber numberWithUnsignedInteger:model.sportCalories]];
    [reading setTotalStepNum:[NSNumber numberWithUnsignedInteger:model.stepCount]];
    
    [self addSportObject:reading];
    return true;
}

- (BOOL)addSleepReadingWithModel:(sleepOneDayInfoModel*)model
{
    SleepDataReadingModel *reading = (SleepDataReadingModel *) [NSEntityDescription insertNewObjectForEntityForName:@"SleepDataReadingModel" inManagedObjectContext:self.managedObjectContext];
    
    [reading setTime:[NSNumber numberWithLong:model.sec]];
    [reading setTotalSleepTime:[NSNumber numberWithLong:model.totalTime]];
    [reading setInSleepTime:[NSNumber numberWithLong:model.inSleepTime]];
    [reading setActiveTime:[NSNumber numberWithLong:model.moveTime]];
    [reading setWakeUpNum:[NSNumber numberWithLong:model.wakeUpTime]];
    
    [self addSleepObject:reading];
    return true;
}

- (BOOL)addHeartRateReadingWithModel:(heartRateOneDayInfoModel*)model
{
    HeartRateDataReadingModel *reading = (HeartRateDataReadingModel *) [NSEntityDescription insertNewObjectForEntityForName:@"HeartRateDataReadingModel" inManagedObjectContext:self.managedObjectContext];
    
    [reading setMode:[NSNumber numberWithInteger:model.mode]];
    [reading setTime:[NSNumber numberWithLong:model.secTotal]];
    [reading setHeartRate:[NSNumber numberWithLong:model.rateVale]];
    
    [self addHeartRateObject:reading];
    return true;
}

#pragma mark - find one
- (NSArray *) findSportsWithDate:(NSDate*)date
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"sportFetchRequest"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    
    NSDate* startTime = [NSDate currentDayStartTime:date];
    NSDate* endTime = [NSDate currentDayEndTime:date];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@", startTime, endTime]];
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Fetching readings failed: %@", error);
    }
    return array;
}
- (NSArray *) findSleepsWithDate:(NSDate*)date
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"sleepFetchRequest"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    
    NSDate* startTime = [NSDate currentDayStartTime:date];
    NSDate* endTime = [NSDate currentDayEndTime:date];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@", startTime, endTime]];
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Fetching readings failed: %@", error);
    }
    return array;
}
- (NSArray *) findHeartRatesWithDate:(NSDate*)date
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"heartFetchRequest"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSDate* startTime = [NSDate currentDayStartTime:date];
    NSDate* endTime = [NSDate currentDayEndTime:date];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@", startTime, endTime]];
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Fetching readings failed: %@", error);
    }
    return array;
}
#pragma mark - fine all
- (NSArray *) allSports
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SportDataReadingModel"];
    NSError *error;
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"personSport.userName LIKE %@", self.userName]];
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Fetching readings failed: %@", error);
    }
    return array;
}
- (NSArray *) allSleeps
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SleepDataReadingModel"];
    NSError *error;
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//    [request setPredicate:[NSPredicate predicateWithFormat:@"personSleep.userName LIKE %@", self.userName]];
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Fetching readings failed: %@", error);
    }
    return array;
}
- (NSArray *) allHeartRates
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HeartRateDataReadingModel"];
    NSError *error;
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//    [request setPredicate:[NSPredicate predicateWithFormat:@"personHeartRate.userName LIKE %@", self.userName]];
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Fetching readings failed: %@", error);
    }
    return array;
}
@end

//
//  SportDataReadingModel.h
//  smartWatch
//
//  Created by Monster on 15-1-7.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PersonDetaiInfo;

@interface SportDataReadingModel : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * kcal;
@property (nonatomic, retain) NSNumber * totalKcal;
@property (nonatomic, retain) NSNumber * totalStepNum;
@property (nonatomic, retain) PersonDetaiInfo *personSport;

@end

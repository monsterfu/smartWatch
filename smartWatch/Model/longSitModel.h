//
//  longSitModel.h
//  smartWatch
//
//  Created by Monster on 14/12/29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    longSitRemindGapEnum_15 = 1,
    longSitRemindGapEnum_30,
    longSitRemindGapEnum_45,
    longSitRemindGapEnum_60
}longSitRemindGapEnum_Enum;



@interface longSitModel : NSObject


@property(nonatomic,assign)NSUInteger startHour1;
@property(nonatomic,assign)NSUInteger startMin1;

@property(nonatomic,assign)NSUInteger endHour1;
@property(nonatomic,assign)NSUInteger endMin1;

@property(nonatomic,assign)NSUInteger startHour2;
@property(nonatomic,assign)NSUInteger startMin2;

@property(nonatomic,assign)NSUInteger endHour2;
@property(nonatomic,assign)NSUInteger endMin2;

@property(nonatomic,assign)longSitRemindGapEnum_Enum remindGap;

@property(nonatomic,assign)BOOL open;

@property(nonatomic,assign)BOOL monday;
@property(nonatomic,assign)BOOL tuesday;
@property(nonatomic,assign)BOOL wednesday;
@property(nonatomic,assign)BOOL thursday;
@property(nonatomic,assign)BOOL friday;
@property(nonatomic,assign)BOOL saturday;
@property(nonatomic,assign)BOOL sunday;

-(char)createInfo;

@end

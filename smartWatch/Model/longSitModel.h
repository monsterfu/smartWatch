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


@property(nonatomic,retain)NSDate* startDate1;
@property(nonatomic,retain)NSDate* startDate2;

@property(nonatomic,retain)NSDate* endDate1;
@property(nonatomic,retain)NSDate* endDate2;

@property(nonatomic,assign)longSitRemindGapEnum_Enum remindGap;

@property(nonatomic,assign)BOOL open;

@property(nonatomic, retain)NSMutableArray* valueArray;//周一至周日的值

-(char)createInfo;


-(NSString*)repeatDetailString;
@end

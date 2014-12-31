//
//  sportOneDayInfoModel.h
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface sportOneDayInfoModel : NSObject

@property(nonatomic, retain)NSDate* date;                   //日期
@property(nonatomic, assign)long stepCount;                 //总步数  3字节  步
@property(nonatomic, assign)long distance;                  //运动距离  3字节 M
@property(nonatomic, assign)long totalCalories;             //总卡路里消耗    2字节
@property(nonatomic, assign)long sportCalories;             //运动卡路里消耗   2字节


-(sportOneDayInfoModel*)initWithData:(NSData*)data;

@end

//
//  personInfoModel.h
//  smartWatch
//
//  Created by Monster on 14-12-29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    EnumHeightUnit_feet = 1,
    EnumHeightUnit_cm,
} EnumHeightUnit_Enum;

typedef enum : NSUInteger {
    EnumWeightUnit_kg = 1,
    EnumWeightUnit_lb,
    EnumWeightUnit_st,
} EnumWeightUnit_Enum;

typedef enum : NSUInteger {
    EnumLengthUnit_km = 1,
    EnumLengthUnit_mile,
} EnumLengthUnit_Enum;



@interface personInfoModel : NSObject


@property(nonatomic, retain)NSString* userName;
@property(nonatomic, retain)NSString* passWord;
@property(nonatomic, assign)NSUInteger height;
@property(nonatomic, assign)NSUInteger weight;
@property(nonatomic, assign)NSUInteger age;
@property(nonatomic, assign)NSUInteger sex;
@property(nonatomic, assign)EnumHeightUnit_Enum heightUnit;
@property(nonatomic, assign)EnumWeightUnit_Enum weightUnit;
@property(nonatomic, assign)EnumLengthUnit_Enum lengthUnit;

+(personInfoModel*)createWithUserName:(NSString*)userName pw:(NSString*)pw height:(NSUInteger)height weight:(NSUInteger)weight age:(NSUInteger)age sex:(NSUInteger)sex;
+(personInfoModel*)createWithUserName:(NSString*)userName pw:(NSString*)pw;

-(NSData*)registerDataWithIndex:(NSUInteger)index;
-(NSData*)loginDataWithIndex:(NSUInteger)index;
@end

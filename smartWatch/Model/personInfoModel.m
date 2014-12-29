//
//  personInfoModel.m
//  smartWatch
//
//  Created by Monster on 14-12-29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "personInfoModel.h"


@implementation personInfoModel


#define BCD_CO(x)    (x/10)*16 + (x%10)
#define DATA_LENGTH         (15)


+(personInfoModel*)initWithUserName:(NSString*)userName pw:(NSString*)pw height:(NSUInteger)height weight:(NSUInteger)weight age:(NSUInteger)age sex:(NSUInteger)sex
{
    personInfoModel* personInfo = [[personInfoModel alloc]init];
    personInfo.userName = userName;
    personInfo.passWord = pw;
    personInfo.height = height;
    personInfo.weight = weight;
    personInfo.age = age;
    personInfo.sex = sex;
    personInfo.heightUnit = EnumHeightUnit_cm;
    personInfo.weightUnit = EnumWeightUnit_kg;
    personInfo.lengthUnit = EnumLengthUnit_km;
    return personInfo;
}


+(personInfoModel*)initWithUserName:(NSString*)userName pw:(NSString*)pw
{
    personInfoModel* personInfo = [[personInfoModel alloc]init];
    personInfo.userName = userName;
    personInfo.passWord = pw;
    personInfo.height = 170;
    personInfo.weight = 70;
    personInfo.age = 29;
    personInfo.sex = 1;
    return personInfo;
}

-(NSData*)registerDataWithIndex:(NSUInteger)index
{
    NSData* nameData = [_userName dataUsingEncoding:NSUTF8StringEncoding];
    NSData* pwData = [_passWord dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char height = BCD_CO(_height);
    NSData* heiData = [[NSData alloc]initWithBytes:&height length:1];
    
    unsigned char weight = BCD_CO(_weight);
    NSData* weiData = [[NSData alloc]initWithBytes:&weight length:1];
    
    unsigned char age = BCD_CO(_age);
    NSData* ageData = [[NSData alloc]initWithBytes:&age length:1];
    
    unsigned char sex = BCD_CO(_sex);
    NSData* sexData = [[NSData alloc]initWithBytes:&sex length:1];
    
    unsigned char heightUnit = BCD_CO(_heightUnit);
    NSData* heightUnitData = [[NSData alloc]initWithBytes:&heightUnit length:1];
    
    unsigned char weightUnit = BCD_CO(_weightUnit);
    NSData* weightUnitData = [[NSData alloc]initWithBytes:&weightUnit length:1];
    
    unsigned char lengthUnit = BCD_CO(_lengthUnit);
    NSData* lengthUnitData = [[NSData alloc]initWithBytes:&lengthUnit length:1];
    
    NSMutableData* destData = [NSMutableData dataWithData:nameData];
    [destData appendData:pwData];
    [destData appendData:heiData];
    [destData appendData:weiData];
    [destData appendData:ageData];
    [destData appendData:sexData];
    [destData appendData:heightUnitData];
    [destData appendData:weightUnitData];
    [destData appendData:lengthUnitData];
    
    NSRange curRange = NSMakeRange(index*DATA_LENGTH, DATA_LENGTH);
    return [destData subdataWithRange:curRange];
}

-(NSData*)loginDataWithIndex:(NSUInteger)index
{
    NSData* nameData = [_userName dataUsingEncoding:NSUTF8StringEncoding];
    NSData* pwData = [_passWord dataUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char height = BCD_CO(_height);
    NSData* heiData = [[NSData alloc]initWithBytes:&height length:1];
    
    unsigned char weight = BCD_CO(_weight);
    NSData* weiData = [[NSData alloc]initWithBytes:&weight length:1];
    
    unsigned char age = BCD_CO(_age);
    NSData* ageData = [[NSData alloc]initWithBytes:&age length:1];
    
    unsigned char sex = BCD_CO(_sex);
    NSData* sexData = [[NSData alloc]initWithBytes:&sex length:1];
    
    unsigned char heightUnit = BCD_CO(1);
    NSData* heightUnitData = [[NSData alloc]initWithBytes:&heightUnit length:1];
    
    unsigned char weightUnit = BCD_CO(1);
    NSData* weightUnitData = [[NSData alloc]initWithBytes:&weightUnit length:1];
    
    unsigned char lengthUnit = BCD_CO(1);
    NSData* lengthUnitData = [[NSData alloc]initWithBytes:&lengthUnit length:1];
    
    NSMutableData* destData = [NSMutableData dataWithData:nameData];
    [destData appendData:pwData];
    [destData appendData:heiData];
    [destData appendData:weiData];
    [destData appendData:ageData];
    [destData appendData:sexData];
    [destData appendData:heightUnitData];
    [destData appendData:weightUnitData];
    [destData appendData:lengthUnitData];
    
    NSRange curRange = NSMakeRange(index*DATA_LENGTH, DATA_LENGTH);
    return [destData subdataWithRange:curRange];
}
@end

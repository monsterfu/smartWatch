//
//  personInfoModel.m
//  smartWatch
//
//  Created by Monster on 14-12-29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "personInfoModel.h"
#import "GlobalHeader.h"


@implementation personInfoModel


#define BCD_CO(x)    (x/10)*16 + (x%10)
#define DATA_LENGTH         (15)


+(personInfoModel*)createWithUserName:(NSString*)userName pw:(NSString*)pw height:(NSUInteger)height weight:(NSUInteger)weight age:(NSUInteger)age sex:(NSUInteger)sex
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


+(personInfoModel*)createWithUserName:(NSString*)userName pw:(NSString*)pw
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
    unsigned char command[32] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    NSData* restData = [[NSData alloc]initWithBytes:command length:32];
    
    NSData* nameData = [_userName dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* nameMutableData = [NSMutableData dataWithData:nameData];
    [nameMutableData appendBytes:restData.bytes length:32- nameData.length];
    NSData* pwData = [_passWord dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* pwMutableData = [NSMutableData dataWithData:pwData];
    [pwMutableData appendBytes:restData.bytes length:32- pwData.length];
    
    NSData* heiData = [[NSData alloc]initWithBytes:&_height length:1];
    NSData* weiData = [[NSData alloc]initWithBytes:&_weight length:1];
    NSData* ageData = [[NSData alloc]initWithBytes:&_age length:1];
    NSData* sexData = [[NSData alloc]initWithBytes:&_sex length:1];
    NSData* heightUnitData = [[NSData alloc]initWithBytes:&_heightUnit length:1];
    NSData* weightUnitData = [[NSData alloc]initWithBytes:&_weightUnit length:1];
    NSData* lengthUnitData = [[NSData alloc]initWithBytes:&_lengthUnit length:1];
    
    NSMutableData* destData = [NSMutableData dataWithData:nameMutableData];
    [destData appendData:pwMutableData];
    [destData appendData:heiData];
    [destData appendData:weiData];
    [destData appendData:ageData];
    [destData appendData:sexData];
    [destData appendData:heightUnitData];
    [destData appendData:weightUnitData];
    [destData appendData:lengthUnitData];
    
    NSData* finData = nil;
    if (destData.length >= index*DATA_LENGTH+DATA_LENGTH) {
        NSRange curRange = NSMakeRange(index*DATA_LENGTH, DATA_LENGTH);
        finData = [destData subdataWithRange:curRange];
    }else if (destData.length < index*DATA_LENGTH+DATA_LENGTH && destData.length > index*DATA_LENGTH) {
        NSRange curRange = NSMakeRange(index*DATA_LENGTH, destData.length - index*DATA_LENGTH);
        finData = [destData subdataWithRange:curRange];
    }else{
        return nil;
    }
    NSLog(@"finData:%@",finData);
    return finData;
}

-(NSData*)loginDataWithIndex:(NSUInteger)index
{
    unsigned char command[32] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    NSData* restData = [[NSData alloc]initWithBytes:command length:32];
    
    NSData* nameData = [_userName dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* nameMutableData = [NSMutableData dataWithData:nameData];
    [nameMutableData appendBytes:restData.bytes length:32- nameData.length];
    NSData* pwData = [_passWord dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* pwMutableData = [NSMutableData dataWithData:pwData];
    [pwMutableData appendBytes:restData.bytes length:32- pwData.length];
    
    
    NSData* heiData = [[NSData alloc]initWithBytes:&_height length:1];
    NSData* weiData = [[NSData alloc]initWithBytes:&_weight length:1];
    NSData* ageData = [[NSData alloc]initWithBytes:&_age length:1];
    NSData* sexData = [[NSData alloc]initWithBytes:&_sex length:1];
    
    unsigned char heightUnit = BCD_CO(1);
    NSData* heightUnitData = [[NSData alloc]initWithBytes:&heightUnit length:1];
    
    unsigned char weightUnit = BCD_CO(1);
    NSData* weightUnitData = [[NSData alloc]initWithBytes:&weightUnit length:1];
    
    unsigned char lengthUnit = BCD_CO(1);
    NSData* lengthUnitData = [[NSData alloc]initWithBytes:&lengthUnit length:1];
    
    NSMutableData* destData = [NSMutableData dataWithData:nameMutableData];
    [destData appendData:pwMutableData];
    [destData appendData:heiData];
    [destData appendData:weiData];
    [destData appendData:ageData];
    [destData appendData:sexData];
    [destData appendData:heightUnitData];
    [destData appendData:weightUnitData];
    [destData appendData:lengthUnitData];
    
    NSData* finData = nil;
    if (destData.length >= index*DATA_LENGTH+DATA_LENGTH) {
        NSRange curRange = NSMakeRange(index*DATA_LENGTH, DATA_LENGTH);
        finData = [destData subdataWithRange:curRange];
    }else if (destData.length < index*DATA_LENGTH+DATA_LENGTH && destData.length > index*DATA_LENGTH) {
        NSRange curRange = NSMakeRange(index*DATA_LENGTH, destData.length - index*DATA_LENGTH);
        finData = [destData subdataWithRange:curRange];
    }else{
        return nil;
    }
    NSLog(@"finData:%@",finData);
    return finData;
}

#pragma mark --

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userName forKey:KEY_PersonInfoModel_username];
    [aCoder encodeObject:_passWord forKey:KEY_PersonInfoModel_psw];
    [aCoder encodeInteger:_height forKey:KEY_PersonInfoModel_height];
    [aCoder encodeInteger:_weight forKey:KEY_PersonInfoModel_weight];
    [aCoder encodeInteger:_age forKey:KEY_PersonInfoModel_age];
    [aCoder encodeInteger:_sex forKey:KEY_PersonInfoModel_sex];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        _userName  = [aDecoder decodeObjectForKey:KEY_PersonInfoModel_username];
        _passWord  = [aDecoder decodeObjectForKey:KEY_PersonInfoModel_psw];
        _height  = [aDecoder decodeIntegerForKey:KEY_PersonInfoModel_height];
        _weight  = [aDecoder decodeIntegerForKey:KEY_PersonInfoModel_weight];
        _age = [aDecoder decodeIntegerForKey:KEY_PersonInfoModel_age];
        _sex = [aDecoder decodeIntegerForKey:KEY_PersonInfoModel_sex];
    }
    return self;
}
@end

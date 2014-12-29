//
//  oneLedDeviceObject.h
//  bleLED
//
//  Created by Monster on 14-11-16.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalHeader.h"



#define INT_VALUE_KEY           @"int"
#define NAME_VALUE_KEY          @"name"
#define BOOL_VALUE_KEY          @"bool"
#define IDENTIFIER_VALUE_KEY    @"identifier"
#define COLORSET_VALUE_KEY      @"colorset"


struct user_info
{
    /* 用户名最多 32 字节,空余字节填 0 */ /* 密码最多 32 字节,空余字节填 0 */
    char username[32];
    char password[32];
    unsigned char height;   /* 单位: CM */
    unsigned char weight;   /* 单位: Kg */
    unsigned char age;
    unsigned char sex;
    unsigned char unit_set[3]; /* 单位设置, 分别对应身高、体重、长度 */
};


@interface oneLedDeviceObject : NSObject

@property(nonatomic, retain)CBPeripheral *peripheral;
@property(nonatomic, retain)CBCharacteristic *characteristic;
@property(nonatomic, retain)CBCharacteristic *characteristic2;
@property(nonatomic, retain)NSString *name;
@property(nonatomic, retain)NSString *identifier;
@property(nonatomic, assign)BOOL open;
@property(nonatomic, assign)BOOL connected;
@property(nonatomic, assign)BOOL isConnecting;

@property(nonatomic, retain)colorSetObject* colorset;

//创建
+(oneLedDeviceObject*) createDeviceObjectWithName:(NSString*)name identifier:(NSString*)identifier;

//同步时间
-(void)syncCurrentTime;


/**
 *  固件更新
 */
//查询固件更新历史断点续传信息
-(void)sendCommandgjgx_requestVisionHistoryInfo;
//传送固件信息
-(void)sendCommandgjgx_sendVisionInfo;
//传送完成
-(void)sendCommandgjgx_requestVisionSendFinished;


/**
 *  用户注册
 */
//查询设备是否已经注册
-(void)sendCommandyhzc_requestDeviceWhetherRegistered;
//传送用户信息
-(void)sendCommandyhzc_sendRegisterInfoWithPerson:(personInfoModel*)person index:(NSUInteger)index;
//传送用户信息完毕
-(void)sendCommandyhzc_sendRegisterInfoFinished;


/**
 *  用户登录
 */
//发送用户信息
-(void)sendCommandyhdl_sendUserInfoWithPerson:(personInfoModel*)person index:(NSUInteger)index;
//传送用户信息完毕
-(void)sendCommandyhdl_sendUserInfoFinished;


/**
 *  运动历史记录
 */
//同步命令
-(void)sendCommandydxx_requestHistoryInfo;
//逐条ack
-(void)sendCommandydxx_requestPerAck;


/**
 *  睡眠历史记录同步
 */
//同步命令
-(void)sendCommandsmxx_requestHistoryInfo;
//逐条ack
-(void)sendCommandsmxx_requestPerAck;


/**
 *  心率历史记录同步
 */
//同步命令
-(void)sendCommandxlxx_requestHistoryInfo;
//逐条ack
-(void)sendCommandxlxx_requestPerAck;


/**
 *  设置
 */

//个人信息
-(void)sendCommandSetting_sendPersonInfo:(personInfoModel*)person;
//单位设置
-(void)sendCommandSetting_sendUnitWithHeightUnit:(EnumHeightUnit_Enum)heightUnit weightUnit:(EnumWeightUnit_Enum)weightUnit lengthUnit:(EnumLengthUnit_Enum)lengthUnit;

//闹钟查询
-(void)sendCommandSetting_requestAlarmInfo;
//闹钟设置
-(void)sendCommandSetting_sendAlarmInfo:(AlarmModel*)alarm;

//久坐提醒使能
-(void)sendCommandSetting_sendLongTimeSitRemindEnable:(BOOL)able;
//久坐提醒设置
-(void)sendCommandSetting_sendLongTimeSitRemind:(longSitModel*)longModel;
//防丢报警
-(void)sendCommandSetting_sendAntiLost;
//装置设定-查询固件版本
-(void)sendCommandSetting_requestVision;
//装置设定-查询设备电量
-(void)sendCommandSetting_requestBattery;
//装置设定-使能飞行模式
-(void)sendCommandSetting_sendFlightMode;
//装置设定-设备重置
-(void)sendCommandSetting_sendDeviceReset;
//信息推送
-(void)sendCommandSetting_sendDevicePushEnable:(BOOL)enable;

@end

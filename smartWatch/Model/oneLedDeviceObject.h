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


//查询固件更新历史断点续传信息
-(void)inquireHistoryInfo;



//查询设备是否已经注册
-(void)inquireDeviceRegisterInfo;

//传送用户信息
-(void)sendUserInfoRegisterInfo;

@end

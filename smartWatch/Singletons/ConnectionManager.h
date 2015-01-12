//
//  ConnectionManager.h
//  bleAlarm
//
//  Created by Monster on 14-4-18.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    //同步时间
    ConnectionManagerCommadEnum_TBSJ,
    //固件更新
    ConnectionManagerCommadEnum_GJSJ_lsdd,      //历史断电信息
    ConnectionManagerCommadEnum_GJSJ_csgj,      //传送固件信息
    ConnectionManagerCommadEnum_GJSJ_cssj,      //传送数据包
    ConnectionManagerCommadEnum_GJSJ_cswc,      //传送完成
    //用户注册
    ConnectionManagerCommadEnum_YHZC_sfzc,      //是否已经注册
    ConnectionManagerCommadEnum_YHZC_csxx,      //传送用户信息
    ConnectionManagerCommadEnum_YHZC_cswc,      //传送完成
    //用户登录
    ConnectionManagerCommadEnum_YHDL_fsxx,      //发送用户登录信息
    ConnectionManagerCommadEnum_YHDL_fswc,      //发送完成
    //运动
    ConnectionManagerCommadEnum_YD_lsjl,        //运动历史记录
    
    //睡眠
    ConnectionManagerCommadEnum_SM_lsjl,        //睡眠历史记录
    
    //心率
    ConnectionManagerCommadEnum_SL_lsjl,        //心率历史记录
    
    //ACK
    ConnectionManagerCommadEnum_ACK,            //逐条ACK
    //设置
    ConnectionManagerCommadEnum_SZ_grxx,        //个人信息
    ConnectionManagerCommadEnum_SZ_dwsz,        //单位设置
    ConnectionManagerCommadEnum_SZ_nzcx,        //闹钟设置--闹钟查询
    ConnectionManagerCommadEnum_SZ_nzsz,        //闹钟设置--设置
    
    //久坐提醒
    ConnectionManagerCommadEnum_JZTX_kg,        //久坐提醒开关
    ConnectionManagerCommadEnum_JZTX_sz,        //久坐提醒设置
    
    //防丢报警
    ConnectionManagerCommadEnum_FDTX_bj,        //防丢报警
    
    //装置设置
    ConnectionManagerCommadEnum_ZZSZ_gjbb,      //查询固件版本
    ConnectionManagerCommadEnum_ZZSZ_sbdl,      //设备电量
    ConnectionManagerCommadEnum_ZZSZ_fxms,      //飞行模式
    ConnectionManagerCommadEnum_ZZSZ_sbcz,      //设备重置
    ConnectionManagerCommadEnum_ZZSZ_sxts,      //信息推送
    
    
    ConnectionManagerCommadEnum_MAX
    
    
} ConnectionManagerCommadEnum;


#import "GlobalHeader.h"
@class oneLedDeviceObject;

@protocol ConnectionManagerDelegate <NSObject>
- (void) didDiscoverDevice:(oneLedDeviceObject*)device;
- (void) didDisconnectWithDevice:(oneLedDeviceObject*)device;
- (void) didConnectWithDevice:(oneLedDeviceObject*)device;
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd;
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd;
@end

@interface ConnectionManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate,CBPeripheralManagerDelegate>
{
    NSTimer* checkRssiTimer;
    CBUUID* _batteryUUID;
    NSUInteger _indexRSSI;
}
@property(nonatomic, assign)ConnectionManagerCommadEnum command;
@property(nonatomic,retain)oneLedDeviceObject* deviceObject;
@property(nonatomic,assign)id<ConnectionManagerDelegate> delegate;
@property(nonatomic,strong)CBCentralManager *manager;
@property (strong, nonatomic) CBPeripheralManager       *peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic   *transferCharacteristic;

@property(nonatomic,retain)NSMutableArray* addedDeviceArray;
@property(nonatomic,retain)NSMutableArray* existDeviceArray;

@property(nonatomic,retain)NSMutableDictionary* deviceManagerDictionary;



+ (ConnectionManager*) sharedInstance;
- (void) startScanForDevice;
- (void) stopScanForDevice;

@end

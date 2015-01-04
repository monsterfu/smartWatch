//
//  oneLedDeviceObject.m
//  bleLED
//
//  Created by Monster on 14-11-16.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "oneLedDeviceObject.h"

@implementation oneLedDeviceObject

static unsigned char auchCRCHi[]={
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
    0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
    0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
    0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40,
    0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
    0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40,
    0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
    0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40,
    0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1,
    0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41,
    0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0,
    0x80, 0x41, 0x00, 0xC1, 0x81, 0x40
};
static unsigned char auchCRCLo[]={
    0x00, 0xC0, 0xC1, 0x01, 0xC3, 0x03, 0x02, 0xC2, 0xC6, 0x06,
    0x07, 0xC7, 0x05, 0xC5, 0xC4, 0x04, 0xCC, 0x0C, 0x0D, 0xCD,
    0x0F, 0xCF, 0xCE, 0x0E, 0x0A, 0xCA, 0xCB, 0x0B, 0xC9, 0x09,
    0x08, 0xC8, 0xD8, 0x18, 0x19, 0xD9, 0x1B, 0xDB, 0xDA, 0x1A,
    0x1E, 0xDE, 0xDF, 0x1F, 0xDD, 0x1D, 0x1C, 0xDC, 0x14, 0xD4,
    0xD5, 0x15, 0xD7, 0x17, 0x16, 0xD6, 0xD2, 0x12, 0x13, 0xD3,
    0x11, 0xD1, 0xD0, 0x10, 0xF0, 0x30, 0x31, 0xF1, 0x33, 0xF3,
    0xF2, 0x32, 0x36, 0xF6, 0xF7, 0x37, 0xF5, 0x35, 0x34, 0xF4,
    0x3C, 0xFC, 0xFD, 0x3D, 0xFF, 0x3F, 0x3E, 0xFE, 0xFA, 0x3A,
    0x3B, 0xFB, 0x39, 0xF9, 0xF8, 0x38, 0x28, 0xE8, 0xE9, 0x29,
    0xEB, 0x2B, 0x2A, 0xEA, 0xEE, 0x2E, 0x2F, 0xEF, 0x2D, 0xED,
    0xEC, 0x2C, 0xE4, 0x24, 0x25, 0xE5, 0x27, 0xE7, 0xE6, 0x26,
    0x22, 0xE2, 0xE3, 0x23, 0xE1, 0x21, 0x20, 0xE0, 0xA0, 0x60,
    0x61, 0xA1, 0x63, 0xA3, 0xA2, 0x62, 0x66, 0xA6, 0xA7, 0x67,
    0xA5, 0x65, 0x64, 0xA4, 0x6C, 0xAC, 0xAD, 0x6D, 0xAF, 0x6F,
    0x6E, 0xAE, 0xAA, 0x6A, 0x6B, 0xAB, 0x69, 0xA9, 0xA8, 0x68,
    0x78, 0xB8, 0xB9, 0x79, 0xBB, 0x7B, 0x7A, 0xBA, 0xBE, 0x7E,
    0x7F, 0xBF, 0x7D, 0xBD, 0xBC, 0x7C, 0xB4, 0x74, 0x75, 0xB5,
    0x77, 0xB7, 0xB6, 0x76, 0x72, 0xB2, 0xB3, 0x73, 0xB1, 0x71,
    0x70, 0xB0, 0x50, 0x90, 0x91, 0x51, 0x93, 0x53, 0x52, 0x92,
    0x96, 0x56, 0x57, 0x97, 0x55, 0x95, 0x94, 0x54, 0x9C, 0x5C,
    0x5D, 0x9D, 0x5F, 0x9F, 0x9E, 0x5E, 0x5A, 0x9A, 0x9B, 0x5B,
    0x99, 0x59, 0x58, 0x98, 0x88, 0x48, 0x49, 0x89, 0x4B, 0x8B,
    0x8A, 0x4A, 0x4E, 0x8E, 0x8F, 0x4F, 0x8D, 0x4D, 0x4C, 0x8C,
    0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42,
    0x43, 0x83, 0x41, 0x81, 0x80, 0x40
};

unsigned short CRC16(unsigned char* puchMsg, unsigned short usDataLen,unsigned char* first,unsigned char* second)
{
    unsigned char uchCRCHi = 0xFF ;
    unsigned char uchCRCLo = 0xFF ;
    unsigned char uIndex ;
    while (usDataLen--)
    {
        uIndex = uchCRCHi ^ *puchMsg++;
        uchCRCHi = uchCRCLo ^ auchCRCHi[uIndex];
        uchCRCLo = auchCRCLo[uIndex];
    }
    NSLog(@"%d -- %d", uchCRCHi << 8,uchCRCLo);
    *first = uchCRCHi;
    *second = uchCRCLo;
    return (uchCRCHi << 8 | uchCRCLo) ;
};


//创建
+(oneLedDeviceObject*) createDeviceObjectWithName:(NSString*)name identifier:(NSString*)identifier
{
    oneLedDeviceObject* device = [[oneLedDeviceObject alloc]init];
    device.name = [name stringByAppendingString:[identifier substringToIndex:4]];
    device.isConnecting = NO;
    device.connected = NO;
    device.open = NO;
    
    device.colorset = [colorSetObject createWithInit];
    return device;
}

//同步时间
-(void)syncCurrentTime:(ConnectionManagerCommadEnum)cmd
{
    NSDate* currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:currentDate];
    long weekNumber = 0;
    if ([comps weekday] == 1) {
        weekNumber = BCD_CO(6);
    }else{
        weekNumber = BCD_CO([comps weekday]-2);
    }
    
    long day= BCD_CO([comps day]);
    long year= BCD_CO([comps year]);
    long month= BCD_CO([comps month]);
    long hour= BCD_CO([comps hour]);
    long minute= BCD_CO([comps minute]);
    long second = BCD_CO([comps second]);
    
    unsigned char command[12] = {0xc0,0x0a,year/100,year%100,month,day,weekNumber,hour,minute,second};
    unsigned char crc1, crc2;
    CRC16(command,10,&crc1,&crc2);
    command[10] = crc1;
    command[11] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:12];
    NSLog(@"lookData:%@",lookdata);
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

//查询固件更新历史断点续传信息
-(void)sendCommandgjgx_requestVisionHistoryInfo:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xc1,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
-(void)sendCommandgjgx_sendVisionInfo:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[12] = {0xc1,0x0a};
    
    
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

-(void)sendCommandgjgx_requestVisionSendFinished:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xc2,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}



//查询设备是否已经注册
-(void)sendCommandyhzc_requestDeviceWhetherRegistered:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[5] = {0xc3,0x03,0x01};
    unsigned char crc1, crc2;
    CRC16(command,3,&crc1,&crc2);
    command[3] = crc1;
    command[4] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:5];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

//传送用户信息
-(void)sendCommandyhzc_sendRegisterInfoWithPerson:(personInfoModel*)person index:(NSUInteger)index cmd:(ConnectionManagerCommadEnum)cmd
{
    //C3 length PN data CRC16
    NSData* personData = [person registerDataWithIndex:index];
    if (personData == nil) {
        [self sendCommandyhzc_sendRegisterInfoFinished:ConnectionManagerCommadEnum_YHZC_cswc];
        return;
    }
    unsigned char command[3] = {0xc3,personData.length + 3,index};
    NSData* midData = [[NSData alloc]initWithBytes:command length:3];
    
    NSMutableData* desData = [NSMutableData dataWithData:midData];
    [desData appendData:personData];
    
    
    unsigned char crc1, crc2;
    CRC16((unsigned char*)desData.bytes,desData.length,&crc1,&crc2);
    
    NSData* crc1Data = [[NSData alloc]initWithBytes:&crc1 length:1];
    NSData* crc2Data = [[NSData alloc]initWithBytes:&crc2 length:1];
    
    [desData appendData:crc1Data];
    [desData appendData:crc2Data];
    
    [_peripheral writeValue:desData forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

//传送用户信息完毕
-(void)sendCommandyhzc_sendRegisterInfoFinished:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[5] = {0xc3,0x03,0x02};
    unsigned char crc1, crc2;
    CRC16(command,3,&crc1,&crc2);
    command[3] = crc1;
    command[4] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:5];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
/**
 *  用户登录
 */
//发送用户信息
-(void)sendCommandyhdl_sendUserInfoWithPerson:(personInfoModel*)person index:(NSUInteger)index cmd:(ConnectionManagerCommadEnum)cmd
{
    //C4 length PN data CRC16
    NSData* personData = [person loginDataWithIndex:index];
    if (personData == nil) {
        [self sendCommandyhdl_sendUserInfoFinished:ConnectionManagerCommadEnum_YHDL_fswc];
        return;
    }
    unsigned char command[3] = {0xc4,personData.length + 3,index};
    NSData* midData = [[NSData alloc]initWithBytes:command length:3];
    
    NSMutableData* desData = [NSMutableData dataWithData:midData];
    [desData appendData:personData];
        
    unsigned char crc1, crc2;
    CRC16((unsigned char*)desData.bytes,desData.length,&crc1,&crc2);
    
    NSData* crc1Data = [[NSData alloc]initWithBytes:&crc1 length:1];
    NSData* crc2Data = [[NSData alloc]initWithBytes:&crc2 length:1];
    
    [desData appendData:crc1Data];
    [desData appendData:crc2Data];
    
    [_peripheral writeValue:desData forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//传送用户信息完毕
-(void)sendCommandyhdl_sendUserInfoFinished:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xc4,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}


/**
 *  运动历史记录
 */
//同步命令
-(void)sendCommandydxx_requestHistoryInfo:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xc5,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

//逐条ack
-(void)sendCommandydxx_requestPerAck:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xff,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}


/**
 *  睡眠历史记录同步
 */
//同步命令
-(void)sendCommandsmxx_requestHistoryInfo:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xc6,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//逐条ack
-(void)sendCommandsmxx_requestPerAck:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xff,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

/**
 *  心率历史记录同步
 */
//同步命令
-(void)sendCommandxlxx_requestHistoryInfo:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xc7,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//逐条ack
-(void)sendCommandxlxx_requestPerAck:(ConnectionManagerCommadEnum)cmd
{
    unsigned char command[4] = {0xff,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}


/**
 *  设置
 */

//个人信息
-(void)sendCommandSetting_sendPersonInfo:(personInfoModel*)person cmd:(ConnectionManagerCommadEnum)cmd
{
    //CA 06 height weight age sex CRC16
    NSUInteger height = BCD_CO(person.height);
    NSUInteger weight = BCD_CO(person.weight);
    NSUInteger age = BCD_CO(person.age);
    NSUInteger sex = BCD_CO(person.sex);
    
    unsigned char command[8] = {0xca,0x06,height,weight,age,sex};
    unsigned char crc1, crc2;
    CRC16(command,6,&crc1,&crc2);
    command[6] = crc1;
    command[7] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:8];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

//单位设置
-(void)sendCommandSetting_sendUnitWithHeightUnit:(EnumHeightUnit_Enum)heightUnit weightUnit:(EnumWeightUnit_Enum)weightUnit lengthUnit:(EnumLengthUnit_Enum)lengthUnit cmd:(ConnectionManagerCommadEnum)cmd
{
    NSUInteger height = BCD_CO(heightUnit);
    NSUInteger weight = BCD_CO(weightUnit);
    NSUInteger length = BCD_CO(lengthUnit);
    //CB 05 U0 U1 U2 CRC16
    unsigned char command[7] = {0xcb,0x05,height,weight,length};
    unsigned char crc1, crc2;
    CRC16(command,5,&crc1,&crc2);
    command[5] = crc1;
    command[6] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:7];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

//闹钟查询
-(void)sendCommandSetting_requestAlarmInfo:(ConnectionManagerCommadEnum)cmd
{
    //CC 02 CRC16
    unsigned char command[4] = {0xcc,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//闹钟设置
-(void)sendCommandSetting_sendAlarmInfo:(AlarmModel*)alarm cmd:(ConnectionManagerCommadEnum)cmd
{
    //CC 05 WM AH AM CRC16
    unsigned char wmChar = [alarm createInfo];
    
    NSUInteger hour = BCD_CO(alarm.hour);
    NSUInteger min = BCD_CO(alarm.min);
    
    unsigned char command[7] = {0xcc,0x05,wmChar,hour,min};
    unsigned char crc1, crc2;
    CRC16(command,5,&crc1,&crc2);
    command[5] = crc1;
    command[6] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:7];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}


//久坐提醒
-(void)sendCommandSetting_sendLongTimeSitRemindEnable:(BOOL)able cmd:(ConnectionManagerCommadEnum)cmd
{
    //CD 03 XX CRC16 (使能与关闭) ￼XX: 01–打开 02 – 关闭
    NSUInteger sitEnable = 1;
    if (!able) {
        sitEnable = 2;
    }
    unsigned char command[5] = {0xcd,0x03,sitEnable};
    unsigned char crc1, crc2;
    CRC16(command,3,&crc1,&crc2);
    command[3] = crc1;
    command[4] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:5];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//久坐提醒设置
-(void)sendCommandSetting_sendLongTimeSitRemind:(longSitModel*)longModel cmd:(ConnectionManagerCommadEnum)cmd
{
    //CD 0C INT WM HS0 MS0 HE0 ME0 HS1 MS1 HE1 ME1 CRC16
    unsigned char wmChar = [longModel createInfo];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:longModel.startDate1];
    
    NSUInteger shour1 = BCD_CO([comps hour]);
    NSUInteger smin1 = BCD_CO([comps minute]);
    
    comps = [calendar components:unitFlags fromDate:longModel.endDate1];
    NSUInteger ehour1 = BCD_CO([comps hour]);
    NSUInteger emin1 = BCD_CO([comps minute]);
    
    comps = [calendar components:unitFlags fromDate:longModel.startDate2];
    NSUInteger shour2 = BCD_CO([comps hour]);
    NSUInteger smin2 = BCD_CO([comps minute]);
    
    comps = [calendar components:unitFlags fromDate:longModel.endDate2];
    NSUInteger ehour2 = BCD_CO([comps hour]);
    NSUInteger emin2 = BCD_CO([comps minute]);
    
    unsigned char command[14] = {0xcd,0x0c,longModel.remindGap,wmChar,shour1,smin1,ehour1,emin1,shour2,smin2,ehour2,emin2};
    unsigned char crc1, crc2;
    CRC16(command,12,&crc1,&crc2);
    command[12] = crc1;
    command[13] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:14];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//防丢报警
-(void)sendCommandSetting_sendAntiLost:(ConnectionManagerCommadEnum)cmd
{
    //CE 02 CRC16
    unsigned char command[4] = {0xce,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//装置设定-查询固件版本
-(void)sendCommandSetting_requestVision:(ConnectionManagerCommadEnum)cmd
{
    //CE 02 CRC16
    unsigned char command[4] = {0xcf,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//装置设定-查询设备电量
-(void)sendCommandSetting_requestBattery:(ConnectionManagerCommadEnum)cmd
{
    //CE 02 CRC16
    unsigned char command[4] = {0xd0,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//装置设定-使能飞行模式
-(void)sendCommandSetting_sendFlightMode:(ConnectionManagerCommadEnum)cmd
{
    //CE 02 CRC16
    unsigned char command[4] = {0xd1,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
//装置设定-设备重置
-(void)sendCommandSetting_sendDeviceReset:(ConnectionManagerCommadEnum)cmd
{
    //CE 02 CRC16
    unsigned char command[4] = {0xd2,0x02};
    unsigned char crc1, crc2;
    CRC16(command,2,&crc1,&crc2);
    command[2] = crc1;
    command[3] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:4];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}

//信息推送
-(void)sendCommandSetting_sendDevicePushEnable:(BOOL)enable cmd:(ConnectionManagerCommadEnum)cmd
{
    //D3 03 XX CRC16
    NSUInteger enableInd = 0;
    if (enable) {
        enableInd = 1;
    }
    unsigned char command[5] = {0xd3,0x03,enableInd};
    unsigned char crc1, crc2;
    CRC16(command,3,&crc1,&crc2);
    command[3] = crc1;
    command[4] = crc2;
    NSData* lookdata = [[NSData alloc]initWithBytes:command length:5];
    [_peripheral writeValue:lookdata forCharacteristic:_characteristic type:CBCharacteristicWriteWithResponse];
    [[ConnectionManager sharedInstance]setCommand:cmd];
}
#pragma mark ---
#pragma mark ---  Encode

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:NAME_VALUE_KEY];
    [aCoder encodeBool:_open forKey:BOOL_VALUE_KEY];
    [aCoder encodeObject:_identifier forKey:IDENTIFIER_VALUE_KEY];
    [aCoder encodeObject:_colorset forKey:COLORSET_VALUE_KEY];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        _name  = [aDecoder decodeObjectForKey:NAME_VALUE_KEY];
        _open  = [aDecoder decodeBoolForKey:BOOL_VALUE_KEY];
        _identifier = [aDecoder decodeObjectForKey:IDENTIFIER_VALUE_KEY];
        _colorset = [aDecoder decodeObjectForKey:COLORSET_VALUE_KEY];
    }
    return self;
}
@end

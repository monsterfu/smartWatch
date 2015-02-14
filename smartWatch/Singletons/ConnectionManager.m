//
//  ConnectionManager.m
//  bleAlarm
//
//  Created by Monster on 14-4-18.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "ConnectionManager.h"

#define TRANSFER_SERVICE_UUID                              @"FFE0"
#define TRANSFER_CHARACTERISTIC_RESPONSE_UUID                   @"FFE1"
#define TRANSFER_CHARACTERISTIC_COMMAND_UUID                    @"FFE2"

@implementation ConnectionManager
@synthesize manager;

static ConnectionManager *sharedConnectionManager;

+ (ConnectionManager*) sharedInstance
{
    if (sharedConnectionManager == nil)
    {
        sharedConnectionManager = [[ConnectionManager alloc]initWithDelegate:nil];
        sharedConnectionManager.connectState = ConnectionManagerState_PowerOff;
    }
    return sharedConnectionManager;
}
- (ConnectionManager*) initWithDelegate:(id<ConnectionManagerDelegate>) delegate
{
    if (self = [super init])
    {
        _hasConnectOneDevice = NO;
        _delegate = delegate;
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
//        _peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
        
        _addedDeviceArray = [NSMutableArray array];
        
        _deviceManagerDictionary = [NSMutableDictionary dictionary];
        _indexRSSI = 0;
        NSData* aData = [USER_DEFAULT objectForKey:KEY_DEVICELIST_INFO];
        _addedDeviceArray = [NSKeyedUnarchiver unarchiveObjectWithData:aData];
        _existDeviceArray = [NSMutableArray array];
        if (_addedDeviceArray == nil) {
            _addedDeviceArray = [NSMutableArray array];
        }else{
            
            for (oneLedDeviceObject* device in _addedDeviceArray) {
                [_deviceManagerDictionary setObject:device forKey:device.identifier];
            }
        }
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appWillDetemin) name:NSNotificationCenter_AppWillDetemin object:nil];
    }
    return self;
}
-(void)appWillDetemin
{
    [USER_DEFAULT removeObjectForKey:KEY_DEVICELIST_INFO];
    NSData* aDate = [NSKeyedArchiver archivedDataWithRootObject:_addedDeviceArray];
    [USER_DEFAULT setObject:aDate forKey:KEY_DEVICELIST_INFO];
    [USER_DEFAULT synchronize];
}
-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:NSNotificationCenter_dismissRecordChange object:nil];
}

#pragma mark -scan
- (void) startScanForDevice
{
    NSDictionary* scanOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    
    // Make sure we start scan from scratch
    [manager stopScan];
    
    [manager scanForPeripheralsWithServices:nil options:scanOptions];
}

- (void) stopScanForDevice
{
    [manager stopScan];
}

#pragma mark - ble delegates
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripherals
{
    // Opt out from any other state
    if (peripherals.state != CBPeripheralManagerStatePoweredOn) {
        return;
    }
    
    // We're in CBPeripheralManagerStatePoweredOn state...
    NSLog(@"self.peripheralManager powered on.");
    
    
    // Start with the CBMutableCharacteristic
    self.transferCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_RESPONSE_UUID] properties:CBCharacteristicPropertyWriteWithoutResponse
                                                                          value:nil
                                                                    permissions:CBAttributePermissionsReadable|CBAttributePermissionsWriteable];
    // Then the service
    CBMutableService *transferService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]
                                                                       primary:YES];
    
    // Add the characteristic to the service
    transferService.characteristics = @[self.transferCharacteristic];
    
    // And add it to the peripheral manager
    [self.peripheralManager addService:transferService];
    
    [self.peripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] }];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests
{
    NSLog(@"didReceiveWriteRequests");
    CBATTRequest* request = (CBATTRequest*)[requests objectAtIndex:0];
    _deviceObject = [_deviceManagerDictionary objectForKey:[request.central.identifier UUIDString]];
    if (_deviceObject) {
        CBATTRequest* request = [requests objectAtIndex:0];
        int someInt = 0;
        [request.value getBytes:&someInt length:2];
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    NSLog(@"didReceiveReadRequest :%@",request);
}

- (void)peripheralManager:(CBPeripheralManager *)arg_peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"central:%@,characteristic:%@,%d,%@",central,characteristic.UUID,characteristic.properties,characteristic.value);
    
    uint8_t val = 2;
    NSData* valData = [NSData dataWithBytes:(void*)&val length:sizeof(val)];
    [arg_peripheral updateValue:valData forCharacteristic:characteristic onSubscribedCentrals:@[central]];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"Central unsubscribed from characteristic");
}

#pragma mark - center delegate
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
        {
            if ([central state] == CBCentralManagerStatePoweredOn)
            {
                [self startScanForDevice];
                self.connectState = ConnectionManagerState_NoDeviceConnect;
            }
            else
            {
//                [_delegate isBluetoothEnabled:NO];
            }
            
            NSLog(@"CBCentralManagerStatePoweredOn");
        }
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
            
        default:
            NSLog(@"CM did Change State");
            
            break;
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)args_peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    //屏蔽不可连接设备
    BOOL connectable = [[advertisementData objectForKey:@"kCBAdvDataIsConnectable"]boolValue];
    if (!connectable) {
        return;
    }
    if (![[args_peripheral name] hasPrefix:@"SmartAM"]) {
        return;
    }
    if (_hasConnectOneDevice == YES) {
        return;
    }
    NSLog(@"Discovered unknown device, %@,%@", [args_peripheral name],[args_peripheral.identifier UUIDString]);
//    NSDictionary *serviceData = [advertisementData objectForKey:@"kCBAdvDataServiceData"];
//    if (!serviceData ||
//        (![serviceData objectForKey:[TemperatureFob thermometerServiceUUID]] ||
//         ![serviceData objectForKey:[TemperatureFob batteryServiceUUID]]))
//    {
////        NSLog(@"Discovered unknown device, %@", [args_peripheral name]);
////        return;
//    }
    //屏蔽已连接设备
    if ([_deviceManagerDictionary objectForKey:[args_peripheral.identifier UUIDString]]) {
        _deviceObject = [_deviceManagerDictionary objectForKey:[args_peripheral.identifier UUIDString]];
        _deviceObject.peripheral = args_peripheral;
        if (!_deviceObject.isConnecting) {
            _hasConnectOneDevice = YES;
            [manager connectPeripheral:args_peripheral options:nil];
            _deviceObject.isConnecting = YES;
            [_existDeviceArray addObject:_deviceObject];
            [self.delegate didDiscoverDevice:_deviceObject];
        }
        return;
    }else{
        _deviceObject = [oneLedDeviceObject createDeviceObjectWithName:[args_peripheral name] identifier:[args_peripheral.identifier UUIDString]];
        _deviceObject.identifier = [args_peripheral.identifier UUIDString];
        _deviceObject.peripheral = args_peripheral;
        [_addedDeviceArray addObject:_deviceObject];
        [_deviceManagerDictionary setObject:_deviceObject forKey:_deviceObject.identifier];
        [self.delegate didDiscoverDevice:_deviceObject];
        
        [USER_DEFAULT removeObjectForKey:KEY_DEVICELIST_INFO];
        NSData* aDate = [NSKeyedArchiver archivedDataWithRootObject:_addedDeviceArray];
        [USER_DEFAULT setObject:aDate forKey:KEY_DEVICELIST_INFO];
        [USER_DEFAULT synchronize];
    }
    
}

-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)arg_peripheral error:(NSError *)error{
    NSLog(@"Connecting Fail: %@",error);
    [manager connectPeripheral:arg_peripheral options:nil];
}


- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)persipheral error:(NSError *)error
{
    NSLog(@"disconnect!!!!  error: %@",error);
    
    [USER_DEFAULT removeObjectForKey:KEY_DEVICELIST_INFO];
    NSData* aDate = [NSKeyedArchiver archivedDataWithRootObject:[ConnectionManager sharedInstance].addedDeviceArray];
    [USER_DEFAULT setObject:aDate forKey:KEY_DEVICELIST_INFO];
    [USER_DEFAULT synchronize];
    self.connectState = ConnectionManagerState_Disconnect;
    [manager connectPeripheral:persipheral options:nil];
}

-(void)peripheralDidUpdateRSSI:(CBPeripheral *)arg_peripheral error:(NSError *)error
{
//    NSLog(@"[[[[[[[[[[[[[[[peripheral.ddd:%f]]]]]]]]]]]]]]]",[arg_peripheral.RSSI floatValue]);
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)args_peripheral
{
    [args_peripheral setDelegate:self];
    [args_peripheral readRSSI];
    [args_peripheral discoverServices:nil];
}

-(void)peripheral:(CBPeripheral *)args_peripheral didDiscoverServices:(NSError *)error{
    if (error) {
        NSLog(@"Error discover service: %@",[error localizedDescription]);
        return;
    }
    
    for(CBService *service in args_peripheral.services){
        NSLog(@"Service found with UUID: %@",service.UUID);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]) {
            [args_peripheral discoverCharacteristics:nil forService:service];
        }
    }
    
}
-(void)setDeviceObject:(oneLedDeviceObject *)deviceObject
{
    NSLog(@"deviceObject:%@",deviceObject);
    _deviceObject = deviceObject;
}
-(void)peripheral:(CBPeripheral *)args_peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    if (error) {
        NSLog(@"Error discover Character");
        //;
        return;
    }
    
    for (CBCharacteristic *aChar in service.characteristics)
    {
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_RESPONSE_UUID]]) {
            [args_peripheral setNotifyValue:YES forCharacteristic:aChar];
        }
        if ([aChar.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_COMMAND_UUID]]) {
            _deviceObject = [_deviceManagerDictionary objectForKey:[args_peripheral.identifier UUIDString]];
            _deviceObject.characteristic = aChar;
            _deviceObject.connected = YES;
            self.connectState = ConnectionManagerState_Connected;
            if (self.delegate&&[self.delegate respondsToSelector:@selector(didConnectWithDevice:)]) {
                [self.delegate didConnectWithDevice:_deviceObject];
            }
        }
    }
}

- (void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:
(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"Did write characteristic value : %@ with ID %@", characteristic.value, characteristic.UUID);
    NSLog(@"With error: %@", [error localizedDescription]);
    //code...
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        return;
    }
    NSLog(@"Characteristic value : %@ with ID %@",  characteristic.value, characteristic.UUID);
    
    Byte* byteValue = (Byte*)characteristic.value.bytes;
    if (byteValue[0] == 0xff&&byteValue[1] == 0x02) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didReciveCommandSuccessResponseWithCmd:)]) {
            [self.delegate didReciveCommandSuccessResponseWithCmd:_command];
        }
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didReciveCommandResponseData:cmd:)]) {
            [self.delegate didReciveCommandResponseData:characteristic.value cmd:_command];
        }
    }
}

-(void)peripheral:(CBPeripheral *)args_peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if (error) {
        NSLog(@"didUpdateNotificationStateForCharacteristic error:%@",error);
    }
    NSLog(@"characteristic.UUID:%@  value:%@, characteristic.properties:%d,characteristic:%@",characteristic.UUID,characteristic.value,characteristic.properties,characteristic);
}

@end

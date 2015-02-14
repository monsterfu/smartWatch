//
//  HardWareUpdateViewController.m
//  smartWatch
//
//  Created by Monster on 15/1/29.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "HardWareUpdateViewController.h"

@interface HardWareUpdateViewController ()
@property NSArray *binaries;
@property NSData *firmwareData;
@property CGFloat firmwareDataBytesSent;
@property CGFloat notificationPacketInterval;
@property NSString *appName;
@property int appSize;
@end

#define DFUCONTROLLER_MAX_PACKET_SIZE (14)
#define DFUCONTROLLER_DESIRED_NOTIFICATION_STEPS (20)

@implementation HardWareUpdateViewController

-(void)viewDidAppear:(BOOL)animated
{
    [ConnectionManager sharedInstance].delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView setEmptyFootView];
    _needUpdateSign = NO;
    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_requestVision:ConnectionManagerCommadEnum_ZZSZ_gjbb];
    [ProgressHUD show:@"查询固件版本中"];
    [ConnectionManager sharedInstance].delegate = self;
    
    _updateIdex = 0;
    _currentDataSent = 0;
    _firmwareDataBytesSent = 0;
    NSError *e;
    NSData *jsonData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"binary_list" withExtension:@"json"]];
    NSDictionary *d = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&e];
    self.binaries = [d objectForKey:@"binaries"];
    
    NSDictionary *binary = [self.binaries objectAtIndex:0];
    
    NSURL *firmwareURL = [[NSBundle mainBundle] URLForResource:[binary objectForKey:@"filename"] withExtension:[binary objectForKey:@"extension"]];
    
    self.firmwareData = [NSData dataWithContentsOfURL:firmwareURL];
    if (self.firmwareData.length%DFUCONTROLLER_MAX_PACKET_SIZE) {
        self.notificationPacketInterval = self.firmwareData.length / DFUCONTROLLER_MAX_PACKET_SIZE + 1;
    }else{
        self.notificationPacketInterval = self.firmwareData.length / DFUCONTROLLER_MAX_PACKET_SIZE;
    }
    
    self.appName = firmwareURL.path.lastPathComponent;
    self.appSize = self.firmwareData.length;
    
    NSArray* nameArray = [self.appName componentsSeparatedByString:@"."];
    _newMinorVision = _newMainVision = 0;
    
    if (nameArray.count >= 3) {
        _newMainVision = [[nameArray objectAtIndex:0] integerValue];
        _newMinorVision = [[nameArray objectAtIndex:1] integerValue];
    }
    
    
    NSLog(@"Set firmware with size %lu, notificationPacketInterval: %d", (unsigned long)self.firmwareData.length, self.notificationPacketInterval);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (!_needUpdateSign) {
        return 2;
    }else{
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <= 1) {
        _cell = [tableView dequeueReusableCellWithIdentifier:@"visionNumCellIdentifier" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            _cell.textLabel.text = @"当前版本为:";
            _cell.detailTextLabel.text = [NSString stringWithFormat:@"%@.0%@",_mainVisionStr,_minorVisionStr];
        }else{
            _cell.textLabel.text = @"最新版本为:";
            _cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@"1.03"];
        }
        return _cell;
    }else{
        _updateProgressCell = [tableView dequeueReusableCellWithIdentifier:@"visionUpdateCellIdentifier" forIndexPath:indexPath];
        _updateProgressCell.delegate = self;
        [_updateProgressCell.progressView setProgress:0.0];
        [_updateProgressCell.label setText:@"0%"];
        return _updateProgressCell;
    }
    
}

-(void)setCellProgress:(CGFloat)value
{
    [_updateProgressCell.progressView setProgress:value];
    [_updateProgressCell.label setText:[NSString stringWithFormat:@"%.1f%%",value*100]];
}

#pragma mark - visionUpdateCellDelegate
-(void)updateButtonTouched
{
    [[ConnectionManager sharedInstance].deviceObject sendCommandgjgx_requestVisionHistoryInfo:ConnectionManagerCommadEnum_GJSJ_lsdd];
}
#pragma mark - ConnectionManager Delegate
- (void) didReciveCommandResponseData:(NSData*)data cmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_ZZSZ_gjbb) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe6&&byteValue[1] == 0x04){
            _curMainVision = byteValue[3];
            _curMinorVision = byteValue[2];
            _mainVisionStr = [NSString stringWithFormat:@"%d",byteValue[3]];
            _minorVisionStr = [NSString stringWithFormat:@"%d",byteValue[2]];
            
            if ((_curMainVision < _newMainVision)||((_curMinorVision < _newMinorVision)&&(_curMainVision == _newMainVision))) {
                _needUpdateSign = YES;
            }
            
            [_tableView reloadData];
            [ProgressHUD showSuccess:@"获取完成"];
        }
        
    }
    if (cmd == ConnectionManagerCommadEnum_GJSJ_lsdd) {
        Byte* byteValue = (Byte*)data.bytes;
        if (byteValue[0] == 0xe0&&byteValue[1] == 0x02){
            [[ConnectionManager sharedInstance].deviceObject sendCommandgjgx_sendVisionNumMainVision:_newMainVision MinorVision:_newMinorVision totalBytesNum:self.appSize packageNum:self.notificationPacketInterval cmd:ConnectionManagerCommadEnum_GJSJ_csgj];
        }
    }
    
    
}
- (void) didReciveCommandSuccessResponseWithCmd:(ConnectionManagerCommadEnum)cmd
{
    if (cmd == ConnectionManagerCommadEnum_SZ_nzsz) {
        [ProgressHUD showSuccess:@"闹钟设置成功!"];
    }
    if (cmd == ConnectionManagerCommadEnum_GJSJ_csgj) {
        if (_updateIdex < self.notificationPacketInterval&& self.firmwareDataBytesSent < self.firmwareData.length)
        {
            unsigned long length = (self.firmwareData.length - self.firmwareDataBytesSent) > DFUCONTROLLER_MAX_PACKET_SIZE ? DFUCONTROLLER_MAX_PACKET_SIZE : self.firmwareData.length - self.firmwareDataBytesSent;
            
            NSRange currentRange = NSMakeRange(self.firmwareDataBytesSent, length);
            NSData *currentData = [self.firmwareData subdataWithRange:currentRange];
            
            [[ConnectionManager sharedInstance].deviceObject sendCommandgjgx_sendData:currentData num:_updateIdex cmd:ConnectionManagerCommadEnum_GJSJ_csgj];
             _updateIdex ++;
            self.firmwareDataBytesSent += length;
            _currentDataSent += length;
            
            CGFloat totalData = self.firmwareData.length;
            [self setCellProgress:_firmwareDataBytesSent/totalData];
        }else{
            [[ConnectionManager sharedInstance].deviceObject sendCommandgjgx_requestVisionSendFinished:ConnectionManagerCommadEnum_GJSJ_cswc];
        }

        
        
    }
}
#pragma mark - alarmTableViewCellDelegate
-(void)alarmTableViewCell_SwitchOpen:(BOOL)open tag:(NSUInteger)tag
{
    
    [ProgressHUD show:@"闹钟设置中"];
    //    [[ConnectionManager sharedInstance].deviceObject sendCommandSetting_sendAlarmInfo:_alarmArray cmd:ConnectionManagerCommadEnum_SZ_nzsz];
    //}
}

@end

//
//  GlobalHeader.h
//  bleLED
//
//  Created by Monster on 14-10-2.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#ifndef bleLED_GlobalHeader_h
#define bleLED_GlobalHeader_h


#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CorePlot-CocoaTouch.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"


#import "NSString+longTimeGapIndex.h"
#import "colorSetObject.h"
#import "UIColor+getColor.h"
#import "CommonNavigationController.h"
#import "thirdParty/MBProgressHUD.h"
#import "ConnectionManager.h"

//model
#import "personInfoModel.h"
#import "AlarmModel.h"
#import "oneLedDeviceObject.h"
#import "SceneArrayDeviceObject.h"

#define IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ?YES:NO)
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


#define BCD_CO(x)    (x/10)*16 + (x%10)

#define KEY_DEVICELIST_INFO   @"key_devicelist_info"         //设备列表

#define KEY_SCENELIST_INFO    @"key_scenelist_info"         //情景列表


/**
 *  首次登陆
 */
#define KEY_First_Use                  @"key_first_use"


/**
 *  久坐提醒
 */
#define KEY_LONGSIT_STARTTIMEONE        @"KEY_LONGSIT_STARTTIMEONE"
#define KEY_LONGSIT_STARTTIMETWO        @"KEY_LONGSIT_STARTTIMETWO"
#define KEY_LONGSIT_ENDTIMEONE          @"KEY_LONGSIT_ENDTIMEONE"
#define KEY_LONGSIT_ENDTIMETWO          @"KEY_LONGSIT_ENDTIMETWO"
#define KEY_longSitRemindGap            @"KEY_longSitRemindGap"
#define KEY_longSitRemindOpen           @"KEY_longSitRemindOpen"

/**
 *  单位
 */
#define KEY_HeightUnit                  @"KEY_HeightUnit"
#define KEY_WeightUnit                  @"KEY_WeightUnit"
#define KEY_LengthUnit                  @"KEY_LengthUnit"


#define NSNotificationCenter_AppWillDetemin                 @"NSNotificationCenter_AppWillDetemin" //APP退出

#endif

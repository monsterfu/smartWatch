//
//  AlarmModel.h
//  smartWatch
//
//  Created by Monster on 14-12-29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmModel : NSObject

@property(nonatomic,assign)NSUInteger hour;
@property(nonatomic,assign)NSUInteger min;
@property(nonatomic,assign)char selectWeek;

/**
 *  monday星期一=忙day，tuesday星期二=求死day，wednesday星期三=未死day，thursday星期四=受死day，friday星期五=福来day，saturday星期六=洒脱day，sunday星期天=伤day
 */
@property(nonatomic,assign)BOOL monday;
@property(nonatomic,assign)BOOL tuesday;
@property(nonatomic,assign)BOOL wednesday;
@property(nonatomic,assign)BOOL thursday;
@property(nonatomic,assign)BOOL friday;
@property(nonatomic,assign)BOOL saturday;
@property(nonatomic,assign)BOOL sunday;

@property(nonatomic,assign)BOOL enable;

/**
 *  创建一个按位表示周几有效的字节数据
 *
 *  @return
 */
-(char)createInfo;

@end

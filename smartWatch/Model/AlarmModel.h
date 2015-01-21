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


@property(nonatomic, retain)NSMutableArray* valueArray;//周一至周日的值

@property(nonatomic,assign)BOOL enable;

/**
 *  创建一个按位表示周几有效的字节数据
 *
 *  @return
 */
-(char)createInfo;

- (AlarmModel*)initWithData:(NSData*)data;

-(NSString*)repeatDetailString;
-(NSString*)timeDetailString;
@end

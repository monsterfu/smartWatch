//
//  CommonTabbarViewController.h
//  Mio
//
//  Created by 符鑫 on 14-8-27.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDetaiInfo.h"
#import "UIColor+getColor.h"

//#import "SportsMainViewController.h"
@class SportsMainViewController;

@interface CommonTabbarViewController : UITabBarController<UITabBarControllerDelegate>
{
    SportsMainViewController* _sportVContrl;
    
}

@property(nonatomic, retain)PersonDetaiInfo* personDetailInfo;

@end

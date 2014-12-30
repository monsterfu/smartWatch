//
//  SettingMainViewController.h
//  smartWatch
//
//  Created by Monster on 14/12/28.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"


@interface SettingMainViewController : UIViewController
{
    NSArray* _titleArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

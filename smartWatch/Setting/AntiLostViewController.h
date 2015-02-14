//
//  AntiLostViewController.h
//  smartWatch
//
//  Created by Monster on 15/1/29.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface AntiLostViewController : UIViewController<ConnectionManagerDelegate>
{
    UITableViewCell* _cell;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;





@end

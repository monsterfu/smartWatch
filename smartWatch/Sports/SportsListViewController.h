//
//  SportsListViewController.h
//  smartWatch
//
//  Created by Monster on 14-12-31.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface SportsListViewController : UIViewController
{
    SportDataReadingModel* _sportCoreDataModel;
}

@property(nonatomic, retain)NSArray* allsportsArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

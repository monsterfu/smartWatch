//
//  HardWareUpdateViewController.h
//  smartWatch
//
//  Created by Monster on 15/1/29.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "visionUpdateCell.h"

@interface HardWareUpdateViewController : UIViewController<ConnectionManagerDelegate,visionUpdateCellDelegate>
{
    UITableViewCell* _cell;
    visionUpdateCell* _updateProgressCell;
    BOOL _needUpdateSign;
    
    NSString* _mainVisionStr;
    NSString* _minorVisionStr;
    
    NSUInteger _curMainVision;
    NSUInteger _curMinorVision;
    NSUInteger _newMainVision;
    NSUInteger _newMinorVision;
    
    NSUInteger _updateIdex;
    NSUInteger _currentDataSent;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

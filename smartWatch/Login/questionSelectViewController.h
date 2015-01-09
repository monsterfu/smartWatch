//
//  questionSelectViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-9.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@protocol questionSelectViewControllerDelegate <NSObject>

-(void)questionSelect:(NSUInteger)row;

@end

@interface questionSelectViewController : UIViewController
{
    NSArray* _titleArray;
}

@property(nonatomic, assign)id<questionSelectViewControllerDelegate>delegate;
@property (nonatomic, retain)NSNumber* questionIdex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

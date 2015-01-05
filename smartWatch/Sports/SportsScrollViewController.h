//
//  SportsScrollViewController.h
//  smartWatch
//
//  Created by Monster on 15-1-5.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "SportsCircleViewController.h"
#import "SportsDetailViewController.h"

@interface SportsScrollViewController : UIViewController
{
    SportsCircleViewController *_circleViewController;
    SportsDetailViewController *_detailViewController;
}


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

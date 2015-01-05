//
//  UITableView+emptyFootView.m
//  smartWatch
//
//  Created by Monster on 15-1-5.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "UITableView+emptyFootView.h"

@implementation UITableView (emptyFootView)

-(void)setEmptyFootView
{
    UIView* _footView = [UIView new];
    [_footView setBackgroundColor:[UIColor clearColor]];
    [self setTableFooterView:_footView];
}

@end

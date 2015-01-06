//
//  SportsScrollViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-5.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "SportsScrollViewController.h"

#define TABController_Height    (0)

@interface SportsScrollViewController ()

@end

@implementation SportsScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _circleViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SportsCircleID"];
    _detailViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SportsDetailID"];
    
    [_circleViewController.view setFrame:CGRectOffset(CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height), 0, TABController_Height)];
    [_detailViewController.view setFrame:CGRectOffset(CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height), 0, TABController_Height + DEVICE_HEIGHT)];
    
    [_scrollView setContentSize:CGSizeMake(0, DEVICE_HEIGHT*2)];
    
    [_scrollView addSubview:_circleViewController.view];
    [_scrollView addSubview:_detailViewController.view];
    [_scrollView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  SportsCircleViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-5.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "SportsCircleViewController.h"

@interface SportsCircleViewController ()

@end

@implementation SportsCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (IBAction)leftButtonTouch:(UIButton *)sender {
}
- (IBAction)rightButtonTouch:(UIButton *)sender {
}
- (IBAction)syncButtonTouch:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(syncButtonTouch)]) {
        [self.delegate syncButtonTouch];
    }
}
- (IBAction)pushMoreButtonTouch:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushMoreButtonTouch)]) {
        [self.delegate pushMoreButtonTouch];
    }
}
@end

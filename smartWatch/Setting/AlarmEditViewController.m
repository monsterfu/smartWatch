//
//  AlarmEditViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "AlarmEditViewController.h"

@interface AlarmEditViewController ()

@end

@implementation AlarmEditViewController

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

- (IBAction)doneButtonTouch:(UIBarButtonItem *)sender {
}
- (IBAction)datePickerChanged:(UIDatePicker *)sender {
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        _cell = [tableView dequeueReusableCellWithIdentifier:@"editAlarmRepeatCell" forIndexPath:indexPath];
    }else{
        _cell = [tableView dequeueReusableCellWithIdentifier:@"editAlarmDateCell" forIndexPath:indexPath];
    }
    return _cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"weekNumSelectIdentifier" sender:nil];
    }else{
        [_datePicker setDate:[NSDate date] animated:YES];
    }
    
}

@end

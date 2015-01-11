//
//  forgetPswViewController.m
//  smartWatch
//
//  Created by Monster on 15-1-9.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "forgetPswViewController.h"

@interface forgetPswViewController ()

@end

@implementation forgetPswViewController

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
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"questionCellIdentifier" forIndexPath:indexPath];
        _questionLabel = (UILabel*)[cell viewWithTag:2];
    }else if(indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"answerCellIdentifier" forIndexPath:indexPath];
        _answerTextField = (UITextField*)[cell viewWithTag:2];
    }else if(indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"confirmCellIdentifier" forIndexPath:indexPath];
        _confirmButton = (UIButton*)[cell viewWithTag:2];
        [_confirmButton addTarget:self action:@selector(confirmButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }else if(indexPath.row == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"passwordCellIdentifier" forIndexPath:indexPath];
        _passWordLabel = (UILabel*)[cell viewWithTag:2];
    }
//    
//    NSInteger idex = [_questionIdex integerValue];
//    if (indexPath.row == idex) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.delegate&&[self.delegate respondsToSelector:@selector(questionSelect:)]) {
//        [self.delegate questionSelect:indexPath.row];
//    }
//    _questionIdex = [NSNumber numberWithInteger:indexPath.row];
//    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - button
- (void)confirmButtonTouch:(UIButton*)sender
{
    
}
@end

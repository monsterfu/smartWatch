//
//  AlarmModel.m
//  smartWatch
//
//  Created by Monster on 14-12-29.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "AlarmModel.h"

@implementation AlarmModel

-(char)createInfo
{
    char val = 0x00;
    NSUInteger index = 0;
    
    if (_monday) {
        val |= (1<< index);
    }
    index ++;
    if (_tuesday) {
        val |= (1<< index);
    }
    index ++;
    if (_wednesday) {
        val |= (1<< index);
    }
    index ++;
    if (_thursday) {
        val |= (1<< index);
    }
    index ++;
    if (_friday) {
        val |= (1<< index);
    }
    index ++;
    if (_saturday) {
        val |= (1<< index);
    }
    index ++;
    if (_sunday) {
        val |= (1<< index);
    }
    return val;
}

//int a=10;
//int b=a;
//b=b>>（3-1）&1;


@end

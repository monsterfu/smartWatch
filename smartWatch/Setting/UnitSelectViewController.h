//
//  UnitSelectViewController.h
//  smartWatch
//
//  Created by Monster on 14-12-30.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface UnitSelectViewController : UIViewController<ConnectionManagerDelegate>
{
    NSArray* _heightUnitArray;
    NSArray* _weightUnitArray;
    NSArray* _lengthUnitArray;
    
    EnumHeightUnit_Enum _heightUnit;
    EnumWeightUnit_Enum _weightUnit;
    EnumLengthUnit_Enum _lengthUnit;

}


- (IBAction)saveButtonTouched:(UIBarButtonItem *)sender;


@end

//
//  GradientView.h
//  smartWatch
//
//  Created by Monster on 15/1/11.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView
{
    UIColor* _startColor;
    UIColor* _endColor;
}

-(void)redrawStartColor:(UIColor*)startColor endColor:(UIColor*)endcolor;
@end

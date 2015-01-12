//
//  circleView.m
//  smartWatch
//
//  Created by Monster on 15-1-12.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "circleView.h"

@implementation circleView

-(void)setCurColor:(UIColor *)curColor
{
    _curColor = curColor;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat r,g,b,alpha;
    [_curColor getRed:&r green:&g blue:&b alpha:&alpha];
    CGContextSetRGBFillColor(context,  r/255.0f, g/255.0f, b/255.0f, alpha/255.0f);
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, self.frame.size.height/2, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    CGContextStrokePath(context);
}


@end

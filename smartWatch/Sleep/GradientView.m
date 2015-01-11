//
//  GradientView.m
//  smartWatch
//
//  Created by Monster on 15/1/11.
//  Copyright (c) 2015年 Monster. All rights reserved.
//

#import "GradientView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GradientView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)_drawGradientColor:(CGContextRef)p_context
                      rect:(CGRect)p_clipRect
                   options:(CGGradientDrawingOptions)p_options
                    colors:(NSArray *)p_colors {
    CGContextSaveGState(p_context);// 保持住现在的context
    CGContextClipToRect(p_context, p_clipRect);// 截取对应的context
    int colorCount = p_colors.count;
    int numOfComponents = 4;
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colorComponents[colorCount * numOfComponents];
    for (int i = 0; i < colorCount; i++) {
        UIColor *color = p_colors[i];
        CGColorRef temcolorRef = color.CGColor;
        const CGFloat *components = CGColorGetComponents(temcolorRef);
        for (int j = 0; j < numOfComponents; ++j) {
            colorComponents[i * numOfComponents + j] = components[j];
        }
    }
    CGGradientRef gradient =  CGGradientCreateWithColorComponents(rgb, colorComponents, NULL, colorCount);
    CGColorSpaceRelease(rgb);
    CGPoint startPoint = p_clipRect.origin;
    CGPoint endPoint = CGPointMake(CGRectGetMinX(p_clipRect), CGRectGetMaxY(p_clipRect));
    CGContextDrawLinearGradient(p_context, gradient, startPoint, endPoint, p_options);
    CGGradientRelease(gradient);
    CGContextRestoreGState(p_context);// 恢复到之前的context
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
#if 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSArray *colors = [NSArray arrayWithObjects:
                       [UIColor colorWithRed:87.0f/255.0f green:90.0f/255.0f blue:209.0f/255.0f alpha:1.0],
                       [UIColor colorWithRed:159.0f/255.0f green:60.0f/255.0f blue:174.0f/255.0f alpha:1.0],
                       nil];
    [self _drawGradientColor:context
                        rect:self.frame
                     options:kCGGradientDrawsAfterEndLocation
                      colors:colors];
    CGContextStrokePath(context);// 描线,即绘制形状
    CGContextFillPath(context);// 填充形状内的颜色
#else
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGColorSpaceRef myColorSpace  = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat r,g,b,alpha;
    [_startColor getRed:&r green:&g blue:&b alpha:&alpha];
    CGFloat components[8] = {
                            87.0f/255.0f, 90.0f/255.0f, 209.0f/255.0f, 1.0,
                            159.0f/255.0f, 60.0f/255.0f, 174.0f/255.0f, 1.0,
                                };
    
    CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorSpace, components, locations, num_locations);
    CGPoint myStartPoint = CGPointMake(0.0,0.0);
    CGPoint myEndPoint = CGPointMake(1.0, 1.0);
    
    CGContextDrawLinearGradient(contextRef, myGradient, myStartPoint, myEndPoint, 0);
    CGContextStrokePath(contextRef);
    CGContextFillPath(contextRef);
#endif
}

-(void)redrawStartColor:(UIColor*)startColor endColor:(UIColor*)endcolor
{
    _startColor = startColor;
    _endColor = endcolor;
}
@end

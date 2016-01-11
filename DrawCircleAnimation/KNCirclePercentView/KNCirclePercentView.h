//
//  CirclePercentView.h
//  DrawCircleAnimation
//
//  Created by Khoi Nguyen Nguyen on 11/24/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNPercentLabel.h"

typedef enum {
    CirclePercentTypeLine = 0,
    CirclePercentTypePie
} CirclePercentType;

@interface KNCirclePercentView : UIView

@property (nonatomic, strong) NSString *key; 
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;
@property (nonatomic, strong) UILabel *percentLabel;

/*
 * Auto calculated radius base on View's frame
 *
 * @param percent percent of circle to display
 * @param lineWidth witdth of circle
 * @param clockwise determine clockwise
 * @param fillColor color inside cricle
 * @param strokeColor color of circle line
 * @param animatedColors colors array to animated. if this param is nil, Stroke color will be used to draw circle
 */

- (void)drawCircleWithPercent:(CGFloat)percent
                    duration:(CGFloat)duration
                   lineWidth:(CGFloat)lineWidth
                   clockwise:(BOOL)clockwise
                     lineCap:(NSString *)lineCap
                   fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor
              animatedColors:(NSArray *)colors;

- (void)drawPieChartWithPercent:(CGFloat)percent
                       duration:(CGFloat)duration
                      clockwise:(BOOL)clockwise
                      fillColor:(UIColor *)fillColor
                    strokeColor:(UIColor *)strokeColor
                 animatedColors:(NSArray *)colors;

/*
 * Start draw animation
 */
- (void)startAnimation;

@end

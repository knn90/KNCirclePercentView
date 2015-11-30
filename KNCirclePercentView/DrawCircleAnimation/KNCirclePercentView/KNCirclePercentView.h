//
//  CirclePercentView.h
//  DrawCircleAnimation
//
//  Created by Khoi Nguyen Nguyen on 11/24/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNPercentLabel.h"

@interface KNCirclePercentView : UIView

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;
@property (nonatomic, strong) UILabel *percentLabel;

- (void)drawCircleWithRadius:(CGFloat)radius
                     percent:(CGFloat)percent
                    duration:(CGFloat)duration
                   lineWidth:(CGFloat)lineWidth
                   clockwise:(BOOL)clockwise
                   fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor
              animatedColors:(NSArray *)colors;

/*
 * Auto calculate radius
 */

- (void)drawCircleWithPercent:(CGFloat)percent
                    duration:(CGFloat)duration
                   lineWidth:(CGFloat)lineWidth
                   clockwise:(BOOL)clockwise
                   fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor
              animatedColors:(NSArray *)colors;

- (void)startAnimation;

@end

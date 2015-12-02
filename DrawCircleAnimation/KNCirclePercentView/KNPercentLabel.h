//
//  TweenLabel.h
//  DrawCircleAnimation
//
//  Created by Khoi Nguyen Nguyen on 11/25/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KNPercentLayer;
@protocol KNPercentDelegate;

@interface KNPercentLabel : NSObject
@property (strong, nonatomic) CAMediaTimingFunction *timingFunction;

- (instancetype)initWithObject:(UIView *)object key:(NSString *)key from:(CGFloat)fromValue to:(CGFloat)toValue duration:(NSTimeInterval)duration;

- (void)start;
@end

@interface KNPercentLayer : CALayer

@property (strong, nonatomic) id<KNPercentDelegate> tweenDelegate;
@property (nonatomic) CGFloat fromValue;
@property (nonatomic) CGFloat toValue;
@property (nonatomic) NSTimeInterval tweenDuration;

- (instancetype)initWithFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CGFloat)duration;
- (void)startAnimation;
@end

@protocol KNPercentDelegate <NSObject>

- (void)layer:(KNPercentLayer *)layer didSetAnimationPropertyTo:(CGFloat)toValue;
- (void)layerDidStopAnimation;

@end
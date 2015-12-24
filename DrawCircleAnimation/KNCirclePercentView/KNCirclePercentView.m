//
//  CirclePercentView.m
//  DrawCircleAnimation
//
//  Created by Khoi Nguyen Nguyen on 11/24/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

#import "KNCirclePercentView.h"

#define kStartAngle -M_PI_2

@interface KNCirclePercentView()

@property (nonatomic, strong) CAShapeLayer *backgroundLayer;
@property (nonatomic, strong) CAShapeLayer *circle;
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat percent;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) BOOL clockwise;
@property (nonatomic, strong) NSMutableArray *colors;
@end

@implementation KNCirclePercentView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawCircleWithRadius:(CGFloat)radius
                     percent:(CGFloat)percent
                    duration:(CGFloat)duration
                   lineWidth:(CGFloat)lineWidth
                   clockwise:(BOOL)clockwise
                   fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor
              animatedColors:(NSArray *)colors {
    
    self.duration = duration;
    self.percent = percent;
    self.radius = radius;
    self.lineWidth = lineWidth;
    self.clockwise = clockwise;
    self.centerPoint = CGPointMake(self.frame.size.width / 2 - self.radius, self.frame.size.height / 2 - self.radius);
    self.colors = [NSMutableArray new];
    if (colors != nil) {
        for (UIColor *color in colors) {
            [self.colors addObject:(id)color.CGColor];
        }
    } else {
        [self.colors addObject:(id)strokeColor.CGColor];
    }

    [self setupBackgroundLayerWithFillColor:fillColor];
    [self setupCircleLayerWithStrokeColor:strokeColor];
    [self setupPercentLabel];
}


- (void)drawCircleWithPercent:(CGFloat)percent
                     duration:(CGFloat)duration
                    lineWidth:(CGFloat)lineWidth
                    clockwise:(BOOL)clockwise
                    fillColor:(UIColor *)fillColor
                  strokeColor:(UIColor *)strokeColor
               animatedColors:(NSArray *)colors {
 
    self.duration = duration;
    self.percent = percent;
    self.lineWidth = lineWidth;
    self.clockwise = clockwise;
    self.colors = [NSMutableArray new];
    if (colors != nil) {
        for (UIColor *color in colors) {
            [self.colors addObject:(id)color.CGColor];
        }
    } else {
        [self.colors addObject:(id)strokeColor.CGColor];
    }
    
    CGFloat min = MIN(self.frame.size.width, self.frame.size.height);
    self.radius = (min - lineWidth)  / 2;
    self.centerPoint = CGPointMake(self.frame.size.width / 2 - self.radius, self.frame.size.height / 2 - self.radius);
    
    [self setupBackgroundLayerWithFillColor:fillColor];
    [self setupCircleLayerWithStrokeColor:strokeColor];
    [self setupPercentLabel];
}

- (void)setupBackgroundLayerWithFillColor:(UIColor *)fillColor {
    self.backgroundLayer = [CAShapeLayer layer];
    self.backgroundLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius startAngle:kStartAngle endAngle:2*M_PI clockwise:self.clockwise].CGPath;
    
    // Center the shape in self.view
    self.backgroundLayer.position = self.centerPoint;
    
    // Configure the apperence of the circle
    self.backgroundLayer.fillColor = fillColor.CGColor;
    self.backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.backgroundLayer.lineWidth = self.lineWidth;
    self.backgroundLayer.lineCap = kCALineCapRound;
    self.backgroundLayer.rasterizationScale = 2 * [UIScreen mainScreen].scale;
    self.backgroundLayer.shouldRasterize = YES;
    
    // Add to parent layer
    [self.layer addSublayer:self.backgroundLayer];
}

- (void)setupCircleLayerWithStrokeColor:(UIColor *)strokeColor {
    // Set up the shape of the circle
    self.circle = [CAShapeLayer layer];
    CGFloat endAngle = [self calculateToValueWithPercent:self.percent];
    
    // Make a circular shape
    self.circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.radius, self.radius) radius:self.radius startAngle:kStartAngle endAngle:endAngle clockwise:self.clockwise].CGPath;
    
    // Center the shape in self.view
    
    self.circle.position = self.centerPoint;
    
    // Configure the apperence of the circle
    self.circle.fillColor = [UIColor clearColor].CGColor;
    self.circle.strokeColor = strokeColor.CGColor;
    self.circle.lineWidth = self.lineWidth;
    self.circle.lineCap = kCALineCapRound;
    self.circle.shouldRasterize = YES;
    self.circle.rasterizationScale = 2 * [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.circle];
}

- (void)setupPercentLabel {
    self.percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height / 2)];
    NSLayoutConstraint *centerHor = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.percentLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerVer = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.percentLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self addSubview:self.percentLabel];
    self.percentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[centerHor, centerVer]];
    [self layoutIfNeeded];
    self.percentLabel.text = [NSString stringWithFormat:@"%d%%", (int)self.percent];
}

- (void)startAnimation {
    [self drawBackgroundCircle];
    [self drawCircle];
    KNPercentLabel *tween = [[KNPercentLabel alloc] initWithObject:self.percentLabel key:@"text" from:0 to:self.percent duration:self.duration];
    tween.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [tween start];
}

- (void)drawCircle {
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = self.duration; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Add the animation to the circle
    [self.circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
    CAKeyframeAnimation *colorsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
    colorsAnimation.values = self.colors;
//    colorsAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.3], [NSNumber numberWithFloat:0.8], [NSNumber numberWithFloat:1.0], nil];
    colorsAnimation.calculationMode = kCAAnimationPaced;
    colorsAnimation.removedOnCompletion = NO;
    colorsAnimation.fillMode = kCAFillModeForwards;
    colorsAnimation.duration = self.duration;

    [self.circle addAnimation:colorsAnimation forKey:@"strokeColor"];
}

- (void)drawBackgroundCircle {
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = self.duration; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Add the animation to the circle
    [self.backgroundLayer addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
}

- (CGFloat)calculateToValueWithPercent:(CGFloat)percent {
    return (kStartAngle + (percent * 2 * M_PI) / 100);
}

- (NSArray *)calculateColorsWithPercent:(CGFloat)percent {
    NSMutableArray *colorsArray = [NSMutableArray new];
    if (percent <= 30) {
        [colorsArray addObject:(id)[UIColor greenColor].CGColor];
    }
    
    if (percent > 30 && percent <= 80 ) {
        [colorsArray addObject:(id)[UIColor greenColor].CGColor];
        [colorsArray addObject:(id)[UIColor yellowColor].CGColor];
    }
    
    if (percent > 80) {
        [colorsArray addObject:(id)[UIColor greenColor].CGColor];
        [colorsArray addObject:(id)[UIColor yellowColor].CGColor];
        [colorsArray addObject:(id)[UIColor orangeColor].CGColor];
        [colorsArray addObject:(id)[UIColor redColor].CGColor];
    }
    
    return colorsArray;
}

@end



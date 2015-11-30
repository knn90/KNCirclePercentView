//
//  ViewController.m
//  DrawCircleAnimation
//
//  Created by Khoi Nguyen Nguyen on 11/23/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "KNCirclePercentView.h"

@interface ViewController() <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *circleView;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *circle1;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *circle2;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *circle3;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *circle4;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.circleView drawCircleWithRadius:75
                                  percent:60
                                 duration:2
                                lineWidth:15
                                clockwise:YES
                                fillColor:[UIColor clearColor]
                              strokeColor:[UIColor orangeColor] animatedColors:@[[UIColor greenColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor redColor]]];
    self.circleView.percentLabel.font = [UIFont systemFontOfSize:35];
    
    [self.circle1 drawCircleWithPercent:20
                                 duration:2
                                lineWidth:10
                                clockwise:YES
                                fillColor:[UIColor clearColor]
                              strokeColor:[UIColor orangeColor] animatedColors:nil];
    
    [self.circle2 drawCircleWithPercent:40
                                 duration:2
                                lineWidth:15
                                clockwise:YES
                                fillColor:[UIColor clearColor]
                                colors:@[[UIColor greenColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor redColor]]];
    
    [self.circle3 drawCircleWithRadius:75
                                  percent:80
                                 duration:2
                                lineWidth:15
                                clockwise:YES
                                fillColor:[UIColor clearColor]
                              strokeColor:[UIColor orangeColor] animatedColors:nil];
    
    [self.circle4 drawCircleWithRadius:75
                                  percent:100
                                 duration:2
                                lineWidth:15
                                clockwise:YES
                                fillColor:[UIColor clearColor]
                              strokeColor:[UIColor orangeColor] animatedColors:nil];
    
    [self.circleView startAnimation];
    [self.circle1 startAnimation];
    [self.circle2 startAnimation];
    [self.circle3 startAnimation];
    [self.circle4 startAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetAction:(id)sender {
    [self.circleView startAnimation];
    [self.circle1 startAnimation];
    [self.circle2 startAnimation];
    [self.circle3 startAnimation];
    [self.circle4 startAnimation];
}


@end

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
@property (weak, nonatomic) IBOutlet KNCirclePercentView *circleView;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *autoCalculateCircleView;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.radiusLabel.text = @"Radius = 75";
    [self.circleView drawPieChartWithPercent:75
                                   duration:2
                                  clockwise:YES
                                  fillColor:[UIColor clearColor]
                                strokeColor:[UIColor orangeColor]
                             animatedColors:@[[UIColor greenColor],
                                            [UIColor yellowColor],
                                            [UIColor orangeColor],
                                            [UIColor redColor]]];
    self.circleView.percentLabel.font = [UIFont systemFontOfSize:35];
    
    // Auto calculate radius
    [self.autoCalculateCircleView drawCircleWithPercent:60
                               duration:2
                              lineWidth:15
                              clockwise:YES
                              fillColor:[UIColor clearColor]
                            strokeColor:[UIColor orangeColor]
                         animatedColors:nil];
    self.autoCalculateCircleView.percentLabel.font = [UIFont systemFontOfSize:35];

    [self.circleView startAnimation];
    [self.autoCalculateCircleView startAnimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetAction:(id)sender {
    [self.circleView startAnimation];
    [self.autoCalculateCircleView startAnimation];
}


@end

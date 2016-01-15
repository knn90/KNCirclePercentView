//
//  ViewController.m
//  DrawCircleAnimation
//
//  Created by Khoi Nguyen Nguyen on 11/23/15.
//  Copyright © 2015 Khoi Nguyen Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "KNCirclePercentView.h"

@interface ViewController() <UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet KNCirclePercentView *circleView;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *autoCalculateCircleView;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.radiusLabel.text = @"Pie Chart";
    [self.circleView drawPieChartWithPercent:100
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
    [self.autoCalculateCircleView drawCircleWithPercent:100
                               duration:2
                              lineWidth:15
                              clockwise:YES
                                lineCap:kCALineCapRound
                              fillColor:[UIColor clearColor]
                            strokeColor:[UIColor orangeColor]
                         animatedColors:nil];
    self.autoCalculateCircleView.percentLabel.font = [UIFont systemFontOfSize:35];

    [self.circleView startAnimation];
    [self.autoCalculateCircleView startAnimation];
    
    self.textField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetAction:(id)sender {
    [self.textField resignFirstResponder];
    int percent = [self.textField.text intValue];
    if (percent > 100) {
        percent = 100;
    }
    [self.circleView drawPieChartWithPercent:percent
                                    duration:2
                                   clockwise:YES
                                   fillColor:[UIColor clearColor]
                                 strokeColor:[UIColor orangeColor]
                              animatedColors:@[[UIColor greenColor],
                                               [UIColor yellowColor],
                                               [UIColor orangeColor],
                                               [UIColor redColor]]];
    [self.circleView startAnimation];
    
    [self.autoCalculateCircleView drawCircleWithPercent:percent
                                               duration:2
                                              lineWidth:15
                                              clockwise:YES
                                                lineCap:kCALineCapRound
                                              fillColor:[UIColor clearColor]
                                            strokeColor:[UIColor orangeColor]
                                         animatedColors:nil];
    [self.autoCalculateCircleView startAnimation];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:textField.text];
    
    BOOL stringIsValid = [numbersOnly isSupersetOfSet:characterSetFromTextField];
    return stringIsValid;
}

@end

//
//  ViewController.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate>

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labels;
@property NSMutableArray *dice;

@end

@implementation ViewController

#pragma mark -UIView Life Cycles
- (void)viewDidLoad
{
    [super viewDidLoad];

    for (DieLabel *label in self.labels) {
        label.delegate = self;
    }

}

#pragma mark -DieLabelDelegate

-(void)onDieLabelTapped:(UILabel *)label
{
    
}

#pragma mark -IBAction

- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    // loop through the labels (dice)
    for (DieLabel *label in self.labels)
    {
        [label roll];
    }
}

@end

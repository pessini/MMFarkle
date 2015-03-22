//
//  DieLabel.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

- (IBAction)onTapped:(UITapGestureRecognizer *)sender
{
    [self.delegate onDieLabelTapped:self];
}

- (void)roll
{
    NSInteger random = arc4random_uniform(6) + 1;
    [self setText:[NSString stringWithFormat:@"%ld", (long)random]];
}

@end

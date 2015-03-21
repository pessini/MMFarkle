//
//  ViewController.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "GameViewController.h"
#import "DieLabel.h"
#import "MatchingDice.h"

@interface GameViewController () <DieLabelDelegate>

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labels;
@property NSMutableArray *dice;
@property NSMutableArray *diceToMatch;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) IBOutlet UILabel *playerName;

@property (nonatomic, strong) MatchingDice *matchingDice;

@end

@implementation GameViewController

#pragma mark -UIView Life Cycles
- (void)viewDidLoad
{
    [super viewDidLoad];

    // initialize the dice Array which contains all the held dice
    self.dice = [NSMutableArray new];

//    self.matchingDice = [MatchingDice new];

    for (DieLabel *label in self.labels) {
        label.delegate = self;
    }

    self.playerName.text = self.player.name;
    self.userScore.text = [NSString stringWithFormat:@"%lu points", (long)self.player.score];
}

#pragma mark -DieLabelDelegate

-(void)onDieLabelTapped:(UILabel *)label
{
    [label setAlpha:0.5f];
    [self.dice addObject:label];
}

#pragma mark -IBAction

- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    // every Roll re-initilize the array
    self.diceToMatch = nil;
    self.diceToMatch = [NSMutableArray new];

    // loop through the labels (dice)
    for (DieLabel *label in self.labels)
    {
        // insert the dice which need to be matched in diceToMatch array
        // only call roll on the DieLabels not in the dice array
        if (![self.dice containsObject:label])
        {
            [label roll];
            [self.diceToMatch addObject:label.text];
        }
    }

    self.matchingDice = [MatchingDice new];
    NSInteger newScore = [self.matchingDice matchingDice:self.diceToMatch withCurrentScore:self.player.score];
    self.player.score = newScore;
    self.userScore.text = [NSString stringWithFormat:@"%lu points", (long)self.player.score];
}

@end

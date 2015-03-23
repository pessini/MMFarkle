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

@interface GameViewController () <DieLabelDelegate, UICollisionBehaviorDelegate>

@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *labels;
@property NSMutableArray *dice;
@property NSMutableArray *diceToMatch;
@property (weak, nonatomic) IBOutlet UILabel *userScore;
@property (weak, nonatomic) IBOutlet UILabel *playerName;

@property (nonatomic, strong) MatchingDice *matchingDice;

// UIDynamics objects
@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property UIDynamicItemBehavior *dynamicItemBehavior;
@property UIGravityBehavior *gravityBehavior;
@property UICollisionBehavior *collisionBehavior;
@property NSMutableArray *arrayDice;
@property UIView *boxView;

@end

@implementation GameViewController

#pragma mark -UIView Life Cycles
- (void)viewDidLoad
{
    [super viewDidLoad];

    // initialize the dice Array which contains all the held dice
    self.dice = [NSMutableArray new];

    // create the box view for start adding all labels below
    [self createBoxView];

    for (DieLabel *label in self.labels) {
        label.delegate = self;
        [self.arrayDice addObject:label];
        [self.boxView addSubview:label];
    }

    /**
     *  UIDynamics objects - Init
     */

    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.labels];
    self.gravityBehavior =[[UIGravityBehavior alloc] initWithItems:self.labels];
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.labels];

    [self rollAnimation];

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
        // insert the dice that need to be matched in diceToMatch array
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

#pragma mark -UIView

-(void)createBoxView
{                                                         // x   y  width height
    self.boxView = [[UIView alloc] initWithFrame:CGRectMake(8, 345, 354,   295)];
    self.boxView.backgroundColor = [UIColor colorWithRed:0.6 green:1.0 blue:0.7 alpha:1.0];
    [self.view addSubview:self.boxView];
}


#pragma mark -UICollisionBehaviorDelegate

- (void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier {
    identifier = @"top";
    identifier = @"bottom";
    identifier = @"left";
    identifier = @"right";
}

#pragma mark -UIDynamic

- (void)rollAnimation
{
    self.dynamicItemBehavior.elasticity = 0.7;
    self.dynamicItemBehavior.angularResistance = 0.3;
    self.dynamicItemBehavior.friction = 0.3;
    self.dynamicItemBehavior.density = 0.7;

    self.collisionBehavior.collisionDelegate = self;


    /*
        CGPoint point = CGPointMake(self.view.frame.origin.x + self.view.frame.size.width, 
                                    self.view.frame.origin.y + self.view.frame.size.height);
     
                                                                x   y  width  height
        self.boxView = [[UIView alloc] initWithFrame:CGRectMake(8, 345, 354,   295)];
     
                            LABEL - Width 40 x 40 Height
     */



    [self.collisionBehavior addBoundaryWithIdentifier:@"top"
                                            fromPoint:CGPointMake(self.boxView.frame.origin.x + 40,
                                                                  self.view.frame.origin.y)
                                              toPoint:CGPointMake(self.boxView.frame.origin.x + 40, 320)];

    [self.collisionBehavior addBoundaryWithIdentifier:@"bottom"
                                            fromPoint:CGPointMake(self.boxView.frame.origin.x + 40, self.boxView.frame.origin.y + self.boxView.frame.size.height)
                                              toPoint:CGPointMake(self.boxView.frame.origin.x - 40, self.boxView.frame.origin.x + self.boxView.frame.size.height)];

    [self.collisionBehavior addBoundaryWithIdentifier:@"left"
                                            fromPoint:CGPointMake(self.boxView.frame.origin.x + 40, 200)
                                              toPoint:CGPointMake(0, 600)];

    [self.collisionBehavior addBoundaryWithIdentifier:@"right"
                                            fromPoint:CGPointMake(337, 200)
                                              toPoint:CGPointMake(337, 500)];

    [self.collisionBehavior setCollisionMode:UICollisionBehaviorModeEverything];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;

    [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];
    [self.dynamicAnimator addBehavior:self.gravityBehavior];
    [self.dynamicAnimator addBehavior:self.collisionBehavior];
}

@end

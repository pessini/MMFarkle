//
//  MatchingDice.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "MatchingDice.h"

// Constaints - Score rules
NSInteger const minimumScoreToGetOnBoard = 200;
NSInteger const scoreForLastTurn = 5000;
NSInteger const scoreToBeTheWinner = 10000;

NSInteger const allSixDiceEquals = 1000;
NSInteger const threePair = 1000;
NSInteger const aStraight = 1000;

NSInteger const threeOnes = 1000;
NSInteger const threeTwos = 200;
NSInteger const threeThrees = 300;
NSInteger const threeFours = 400;
NSInteger const threeFives = 500;
NSInteger const threeSixes = 600;

NSInteger const onlyAOne = 100;
NSInteger const onlyAFive = 50;

/*
 
 NSIndexSet *targetsIndices = [diceToMatch indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
 {
    return [array containsObject:obj];
 }];

 NSLog(@"%lu", (unsigned long)targetsIndices.firstIndex);
 [number of indexes: 3 (in 2 ranges), indexes: (0 3-4)]
 
 ************ If it needed to order the array **********************
 NSSortDescriptor *ascendingSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
 NSArray *arraySorted = [diceToMatch sortedArrayUsingDescriptors:@[ascendingSortDescriptor]];
 
 */

@implementation MatchingDice

-(NSInteger)matchingDice: (NSMutableArray *)diceToMatch withCurrentScore:(NSInteger)currentScore
{

//    NSArray *array = [NSArray arrayWithObjects:@"3", @"1", @"1", @"3", @"4", @"1", nil];
//    NSLog(@"%s", [self checkIfThreeOnes:array] ? "true" : "false");

    // only possible with 6 dice
    if (diceToMatch.count == 6)
    {
        if ([self checkIfAllSixDiceEquals:diceToMatch])
        {
            currentScore += allSixDiceEquals;
        }
        else if ([self checkIfThreePair:diceToMatch])
        {
            currentScore += threePair;
        }
        else if ([self checkIfItIsStraight:diceToMatch])
        {
            currentScore += aStraight;
        }
    }

    // only possible with 3 or more dice
    if (diceToMatch.count >= 3)
    {
        if ([self checkIfThreeOnes:diceToMatch])
        {
            currentScore += threeOnes;
        }
        else if ([self checkIfThreeTwos:diceToMatch])
        {
            currentScore += threeTwos;
        }
        else if ([self checkIfThreeFours:diceToMatch])
        {
            currentScore += threeFours;
        }
        else if ([self checkIfThreeFives:diceToMatch])
        {
            currentScore += threeFives;
        }
        else if ([self checkIfThreeSixes:diceToMatch])
        {
            currentScore += threeSixes;
        }
    }

    for (NSString *die in diceToMatch)
    {
        if ([die isEqualToString:@"1"])
        {
            currentScore += onlyAOne;
        }
        else if ([die isEqualToString:@"5"])
        {
            currentScore += onlyAFive;
        }
    }

    return currentScore;
}

#pragma mark - Helper Methods

-(BOOL)checkIfAllSixDiceEquals: (NSArray *)array
{
    NSString *firstObject = [array firstObject];
    NSArray *sixEquals = [NSArray arrayWithObjects:
                          firstObject, nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                                  {
                                      return [sixEquals containsObject:obj];
                                  }];
    if (matches.count == 6)
        return true;

    return false;
}

-(BOOL)checkIfThreePair: (NSArray *)array
{
    NSArray *pair = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSIndexSet *matches = [pair indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                           {


                               return [array containsObject:obj];
                           }];


    NSRange range = NSMakeRange(1, 3);
    if ([matches containsIndexesInRange:range])
        return true;

    return false;
}

-(BOOL)checkIfItIsStraight: (NSArray *)array
{
    NSArray *straight = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSSortDescriptor *ascendingSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *arraySorted = [array sortedArrayUsingDescriptors:@[ascendingSortDescriptor]];

    if ([straight isEqualToArray:arraySorted])
        return true;

    return false;
}

-(BOOL)checkIfThreeOnes:(NSArray *)array
{
    NSArray *threeOnes = [NSArray arrayWithObjects:@"1", nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                           {
                               return [threeOnes containsObject:obj];
                           }];
    if (matches.count >= 3)
        return true;

    return false;
}

-(BOOL)checkIfThreeTwos:(NSArray *)array
{
    NSArray *threeTwos = [NSArray arrayWithObjects:@"2", nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                           {
                               return [threeTwos containsObject:obj];
                           }];
    if (matches.count >= 3)
        return true;

    return false;
}

-(BOOL)checkIfThreeThrees:(NSArray *)array
{
    NSArray *threeThrees = [NSArray arrayWithObjects:@"3", nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                           {
                               return [threeThrees containsObject:obj];
                           }];
    if (matches.count >= 3)
        return true;

    return false;
}

-(BOOL)checkIfThreeFours:(NSArray *)array
{
    NSArray *threeFours = [NSArray arrayWithObjects:@"3", nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                           {
                               return [threeFours containsObject:obj];
                           }];
    if (matches.count >= 3)
        return true;

    return false;
}

-(BOOL)checkIfThreeFives:(NSArray *)array
{
    NSArray *threeFives = [NSArray arrayWithObjects:@"3", nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                           {
                               return [threeFives containsObject:obj];
                           }];
    if (matches.count >= 3)
        return true;

    return false;
}

-(BOOL)checkIfThreeSixes:(NSArray *)array
{
    NSArray *threeSixes = [NSArray arrayWithObjects:@"3", nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                           {
                               return [threeSixes containsObject:obj];
                           }];
    if (matches.count >= 3)
        return true;

    return false;
}

//-(BOOL)checkIfHasOne:(NSArray *)array
//{
//    return [array indexOfObjectIdenticalTo:@"1"] != NSNotFound;
//}
//
//-(BOOL)checkIfHasFive:(NSArray *)array
//{
//    return [array indexOfObjectIdenticalTo:@"5"] != NSNotFound;
//}

@end

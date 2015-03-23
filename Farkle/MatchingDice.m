//
//  MatchingDice.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "MatchingDice.h"

@interface MatchingDice()

@property NSMutableArray *arrayDiceMutable;

@end

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

@implementation MatchingDice

-(NSInteger)matchingDice: (NSArray *)diceToMatch withCurrentScore:(NSInteger)currentScore
{
    self.arrayDiceMutable = [[NSMutableArray alloc] initWithArray:diceToMatch];

//     only possible with 6 dice
    if (diceToMatch.count == 6)
    {
        if ([self checkIfAllSixDiceEquals:self.arrayDiceMutable])
        {
            currentScore += allSixDiceEquals;
        }
        else if ([self checkIfThreePair:self.arrayDiceMutable])
        {
            currentScore += threePair;
        }
        else if ([self checkIfItIsStraight:self.arrayDiceMutable])
        {
            currentScore += aStraight;
        }
    }

    // only possible with 3 or more dice

    if (self.arrayDiceMutable.count >= 3)
    {
        while (self.arrayDiceMutable.count >= 3)
        {
            NSString *threeOfAKind = [self checkIfThreeOfAKind:self.arrayDiceMutable];

            if ([threeOfAKind isEqualToString:@"1"])
            {
                currentScore += threeOnes;
            }
            else if ([threeOfAKind isEqualToString:@"2"])
            {
                currentScore += threeTwos;
            }
            else if ([threeOfAKind isEqualToString:@"3"])
            {
                currentScore += threeThrees;
            }
            else if ([threeOfAKind isEqualToString:@"4"])
            {
                currentScore += threeFours;
            }
            else if ([threeOfAKind isEqualToString:@"5"])
            {
                currentScore += threeFives;
            }
            else if ([threeOfAKind isEqualToString:@"6"])
            {
                currentScore += threeSixes;
            }
            else
            {
                break;
            }
        }
    }

    for (NSString *die in self.arrayDiceMutable)
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
    if (!self.arrayDiceMutable)
        return false;

    NSString *firstObject = [array firstObject];
    NSArray *sixEquals = [NSArray arrayWithObjects:
                          firstObject, nil];
    NSIndexSet *matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                                  {
                                      return [sixEquals containsObject:obj];
                                  }];
    if (matches.count != 6)
        return false;

    self.arrayDiceMutable = nil;
    return true;
}

-(BOOL)checkIfThreePair: (NSArray *)array
{
    if (!self.arrayDiceMutable)
        return false;

    NSCountedSet *countedSet = [[NSCountedSet alloc] initWithArray:array];

    int numberOfPairs = 0;

    for (int i=1; i<=6; i++)
    {
        if ([countedSet countForObject:[NSString stringWithFormat:@"%i", i]] == 2)
        {
            numberOfPairs++;
        }
    }

    if (numberOfPairs == 3)
    {
        self.arrayDiceMutable = nil;
        return true;
    }
    else
    {
        return false;
    }
}

-(BOOL)checkIfItIsStraight: (NSArray *)array
{
    if (!self.arrayDiceMutable)
        return false;

    NSArray *straight = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSSortDescriptor *ascendingSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *arraySorted = [array sortedArrayUsingDescriptors:@[ascendingSortDescriptor]];

    if (![straight isEqualToArray:arraySorted])
        return false;

    self.arrayDiceMutable = nil;
    return true;
}

-(NSString *)checkIfThreeOfAKind:(NSArray *)array
{
    NSMutableArray *checkTriple = [NSMutableArray new];
    self.arrayDiceMutable = [NSMutableArray arrayWithArray:array];
    NSIndexSet *matches;

    int i=1;
    for (; i<=6; i++) {
        [checkTriple addObject:[NSString stringWithFormat:@"%i", i]];
        matches = [array indexesOfObjectsPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop)
                   {
                       return [checkTriple containsObject:obj];
                   }];
        if (matches.count >= 3)
            break;

        [checkTriple removeObject:[NSString stringWithFormat:@"%i", i]];
    }

    [matches enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger idx, BOOL *stop) {
        [self.arrayDiceMutable removeObjectAtIndex:idx];
    }];

    return [NSString stringWithFormat:@"%i", i];
}

@end

//
//  MatchingDice.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "MatchingDice.h"

@implementation MatchingDice

-(NSInteger)matchingDice: (NSMutableArray *)diceToMatch withCurrentScore:(NSInteger)currentScore
{
    for (NSString *dieNumber in diceToMatch)
    {
        if ([dieNumber isEqualToString:@"4"])
        {
            currentScore += 1;

        }
    }

    return currentScore;
}

@end

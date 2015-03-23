//
//  MatchingDice.h
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchingDice : NSObject

@property NSMutableArray *diceToMatch;
@property NSInteger currentScore;

-(NSInteger)matchingDice: (NSArray *)diceToMatch withCurrentScore:(NSInteger)currentScore;

@end

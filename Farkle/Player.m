//
//  Player.m
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import "Player.h"

@implementation Player

-(instancetype)initWithName:(NSString *)playerName AndScore:(NSInteger)playerScore
{
    self = [super init];

    if (self) {
        self.name = playerName;
        self.score = playerScore;
    }

    return self;
}


@end

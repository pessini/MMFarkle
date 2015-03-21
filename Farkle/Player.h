//
//  Player.h
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property NSString *name;
@property NSInteger score;

-(instancetype)initWithName: (NSString *)playerName AndScore: (NSInteger)playerScore;

@end

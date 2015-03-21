//
//  DieLabel.h
//  Farkle
//
//  Created by Leandro Pessini on 3/21/15.
//  Copyright (c) 2015 Brazuca Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate <NSObject>

- (void)onDieLabelTapped:(UILabel *)label;

@end

@interface DieLabel : UILabel

@property (nonatomic, assign) id<DieLabelDelegate> delegate;

- (void)roll;

@end

//
//  SubviewFinder.h
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/3/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SubviewHunting)

- (UIView*) huntedSubviewWithClassName:(NSString*) className;
- (void) debugSubviews;

@end


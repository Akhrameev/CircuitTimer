//
//  TimerVC.h
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/8/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerVC : UIViewController {
  NSInteger i;
  NSInteger j;
  NSString *workout_name;
  NSMutableArray *intervals;
  BOOL running;
  double time;
}

@property (weak, nonatomic) NSMutableArray *data;
@property (weak, nonatomic) NSNumber *selected_index;

@property (weak, nonatomic) IBOutlet UILabel *lblTimer;
@property (weak, nonatomic) IBOutlet UILabel *lblNextInterval;
@property (weak, nonatomic) IBOutlet UILabel *lblSets;
@property (weak, nonatomic) IBOutlet UILabel *lblInterval;

- (IBAction)pressedStartStop:(id)sender;

@end

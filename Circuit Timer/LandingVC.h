//
//  LandingVC.h
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/2/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutCellTVC.h"
#import "IntervalVC.h"
#import "TimerVC.h"

@interface LandingVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
  NSMutableArray *data;
  NSNumber *selected_index;
}

@property (weak, nonatomic) IBOutlet UITableView *tblWorkouts;

- (IBAction)pushAddWorkout:(id)sender;

@end

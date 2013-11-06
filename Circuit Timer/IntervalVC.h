//
//  IntervalVC.h
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/2/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "IntervalCellTVC.h"
#import "SubviewFinder.h"

@interface IntervalVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
  NSInteger i;
  NSString *workout_name;
  NSMutableArray *intervals;
  
  UIColor *myGreen;
  UIColor *myRed;
  UIColor *myBlue;
  UIColor *myYellow;

}

@property (weak, nonatomic) IBOutlet UITableView *tblIntervals;
@property (weak, nonatomic) NSMutableArray *data;
@property (weak, nonatomic) NSNumber *selected_index;

- (IBAction)pushAddRepeat:(id)sender;
- (IBAction)pushAddInterval:(id)sender;

@end
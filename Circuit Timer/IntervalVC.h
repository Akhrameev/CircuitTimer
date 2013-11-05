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
  NSMutableArray *values;
}

@property (weak, nonatomic) IBOutlet UITableView *tblIntervals;

- (IBAction)pushAddRepeat:(id)sender;
- (IBAction)pushAddInterval:(id)sender;

@end
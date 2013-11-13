//
//  TimerVC.m
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/8/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import "TimerVC.h"

@interface TimerVC ()

@end

@implementation TimerVC

@synthesize data, selected_index,lblNextInterval,lblSets,lblTimer,lblInterval;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  i = [selected_index integerValue];
  workout_name = data[i][0];
  intervals = data[i][1];
  j = 0;
  
  intervals = [self initiateRepeatsWithBase:intervals];
  
  NSInteger sets = 3;
  
  [lblSets setText:[NSString stringWithFormat:@"%i", sets]];
  [lblInterval setText:[NSString stringWithFormat:@"%@",intervals[j][0]]];
  [lblTimer setText:[self formatTime:intervals[j][1]]];
  [lblNextInterval setText:[NSString stringWithFormat:@"%@ - %@", intervals[j+1][0],[self formatTime:intervals[j+1][1]]]];
  
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedStartStop:(id)sender {
}

- (NSString*)formatTime:(id)seconds {
  NSInteger time = [seconds integerValue];
  if(time/60 == 0)
    return [NSString stringWithFormat:@":%02d", time];
  
  return [NSString stringWithFormat:@"%d:%02d", (time/60), (time%60)];
}

- (NSMutableArray*)initiateRepeatsWithBase:(NSArray*)base {
  
  NSMutableArray* build = [[NSMutableArray alloc] init];
  NSInteger from, to, times;
  NSInteger k, l;
  
  for(k = 0; k < [base count]; k++) {
    if([base[k][0] isEqualToString:@"Repeat"]) {
      
      from = [base[k][2] integerValue] - 1;
      to = [base[k][3] integerValue] - [base[k][2] integerValue] + 1;
      times = 2 - 1;
      
      for(l = 0; l < times; l++)
        [build addObjectsFromArray:[self initiateRepeatsWithBase:[base subarrayWithRange:NSMakeRange(from, to)]]];
    }
    else{
      [build addObject:base[k]];
    }
  }
  
  return build;
}

@end

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
  j = -1;
  running = NO;
  
  workout_name = data[i][0];
  intervals = [[NSMutableArray alloc] initWithArray:data[i][1]];
  intervals = [self initiateRepeatsWithBase:intervals];
  
  NSInteger sets = 3;
  [lblSets setText:[NSString stringWithFormat:@"%i", sets]];
  
  [self nextInterval];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedStartStop:(id)sender {
  if(running)
    running = NO;
  else {
    running = YES;
    [self countdown];
  }
}

- (void)nextInterval {
  j++;
  
  if(j == [intervals count]-1) {
    time = (double)[intervals[j][1] integerValue];
    [lblInterval setText:[NSString stringWithFormat:@"%@",intervals[j][0]]];
    [lblTimer setText:[self formatDisplayTime:intervals[j][1]]];
    [lblNextInterval setText:@"Last Interval!"];
  }
  else if(j == [intervals count]) {
    [lblInterval setText:@":00.0"];
    [lblTimer setText:@"Complete"];
    [lblNextInterval setText:@""];
    running = NO;
  }
  else {
    time = (double)[intervals[j][1] integerValue];
    [lblInterval setText:[NSString stringWithFormat:@"%@",intervals[j][0]]];
    [lblTimer setText:[self formatDisplayTime:intervals[j][1]]];
    [lblNextInterval setText:[NSString stringWithFormat:@"%@ - %@", intervals[j+1][0],[self formatDisplayTime:intervals[j+1][1]]]];
  }
}

- (NSString*)formatDisplayTime:(id)seconds {
  
  NSInteger format = [seconds integerValue];
  if(format/60 == 0) {
    return [NSString stringWithFormat:@":%.02d", format];
  }
  
  return [NSString stringWithFormat:@"%d:%02d", (format/60), (format%60)];
}

- (void)countdown {
  if([[NSString stringWithFormat:@"%.1f", time] isEqualToString:@"0.1"])
    [self nextInterval];

  if(!running)
    return;
  
  time -= .1;
  
  NSString* display = @"";
  
  int seconds = round(time);
  
  if(seconds/60 == 0)
    display = [NSString stringWithFormat:@"%.1f", time];
  else
    display = [NSString stringWithFormat:@"%d:%02d",(seconds/60),(seconds%60)];
  
  [lblTimer setText:[NSString stringWithFormat:@"%@",display]];
  
  
  [self performSelector:@selector(countdown) withObject:self afterDelay:0.1];
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

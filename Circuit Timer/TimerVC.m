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

@synthesize data, selected_index,lblNextInterval,lblSets,lblTimer;

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
  
  NSInteger sets = 3;
  
  [lblSets setText:[NSString stringWithFormat:@"%i", sets]];
  
  
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedStartStop:(id)sender {
}

- (NSString*)minutesFormat:(NSInteger)seconds {
  if(seconds/60 == 0)
    return [NSString stringWithFormat:@":%02d", seconds];
  
  return [NSString stringWithFormat:@"%d:%02d", (seconds/60), (seconds%60)];
}
@end

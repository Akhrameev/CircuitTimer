//
//  LandingVC.m
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/2/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import "LandingVC.h"

@interface LandingVC ()

@end

@implementation LandingVC

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:@"Core Workout", @"Weekly Lift", @"Stretching Routine", @"Wind Sprints", nil];
  
  // Initializing a custom tableviewcell
  WorkoutCellTVC *cell = (WorkoutCellTVC *)[tableView dequeueReusableCellWithIdentifier:@"WorkoutCell"];
  
  // Remove gray table seperators
  [tableView setSeparatorColor:[UIColor clearColor]];
  
  // Configure Cell
  [cell.lblWorkoutName setText:[NSString stringWithFormat:@"%@", values[indexPath.row]]];
  
  // Set alternating background colors
  [cell setBackgroundColor:(indexPath.row % 2 == 0) ? [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1] : [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1]];
  
  // Adding an empty footer prevents any cells beyond what's needed
  tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (IBAction)pushAddWorkout:(id)sender {
  [self performSegueWithIdentifier:@"LandingVC_IntervalVC" sender:nil];
}
@end

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

@synthesize tblWorkouts;

- (void)viewDidLoad
{
  [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
  NSData *dataData = [[NSUserDefaults standardUserDefaults] objectForKey:@"data"];
  data = [NSKeyedUnarchiver unarchiveObjectWithData:dataData];
  
  if(data == NULL)
    data = [[NSMutableArray alloc] init];
  
  [tblWorkouts reloadData];
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
  return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:@"Core Workout", @"Weekly Lift", @"Stretching Routine", @"Wind Sprints", nil];
  
  // Initializing a custom tableviewcell
  WorkoutCellTVC *cell = (WorkoutCellTVC *)[tableView dequeueReusableCellWithIdentifier:@"WorkoutCell"];
  
  [cell.btnEdit setTag:indexPath.row];
  [cell.btnEdit addTarget:self action:@selector(pressedEdit:) forControlEvents:UIControlEventTouchUpInside];
  
  // Remove gray table seperators
  [tableView setSeparatorColor:[UIColor clearColor]];
  
  // Configure Cell
  [cell.lblWorkoutName setText:[NSString stringWithFormat:@"%@", data[indexPath.row][0]]];
  
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //selected_index = [NSNumber numberWithInteger:indexPath.row];
  //[self performSegueWithIdentifier:@"LandingVC_IntervalVC" sender:nil];
}

- (IBAction)pushAddWorkout:(id)sender {
  selected_index = [NSNumber numberWithInteger:-1];
  [self performSegueWithIdentifier:@"LandingVC_IntervalVC" sender:nil];
}

- (void)pressedEdit:(id)sender {
  UIButton *pressed = (UIButton*)sender;
  selected_index = [NSNumber numberWithInteger:pressed.tag];
  [self performSegueWithIdentifier:@"LandingVC_IntervalVC" sender:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  IntervalVC *ivc = [segue destinationViewController];
  [ivc setSelected_index:selected_index];
  [ivc setData:data];
}

@end

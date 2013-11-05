//
//  IntervalVC.m
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/2/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import "IntervalVC.h"
@implementation IntervalVC

@synthesize tblIntervals;

- (void)viewDidLoad
{
  [super viewDidLoad];
  [super setEditing:YES];
  [tblIntervals setEditing:YES];
  
  UIColor *myGreen = [UIColor colorWithRed:106.0/255.0 green:181.0/255.0 blue:88.0/255.0 alpha:1];
  UIColor *myRed = [UIColor colorWithRed:216.0/255.0 green:110.0/255.0 blue:110.0/255.0 alpha:1];
  //UIColor *myBlue = [UIColor colorWithRed:99.0/255.0 green:168.0/255.0 blue:229.0/255.0 alpha:1];
  UIColor *myYellow = [UIColor colorWithRed:216.0/255.0 green:213.0/255.0 blue:110.0/255.0 alpha:1];
  
  NSMutableArray *one = [[NSMutableArray alloc] initWithObjects:@"Crunches", @180, myGreen, nil];
  NSMutableArray *two = [[NSMutableArray alloc] initWithObjects:@"Mountain Climbers", @120, myRed, nil];
  NSMutableArray *three = [[NSMutableArray alloc] initWithObjects:@"Rest", @30, myYellow, nil];
  NSMutableArray *four = [[NSMutableArray alloc] initWithObjects:@"Repeat", @1, @3, nil];
  NSMutableArray *five = [[NSMutableArray alloc] initWithObjects:@"Pull Ups", @90, myGreen, nil];
  values = [[NSMutableArray alloc] initWithObjects:one, two, three, four, five, nil];
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
  if([values count] != 0)
   return [values count];
  
  return 5;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return 60;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [NSString stringWithFormat:@"%02d", row];
}



- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	//	Grip customization code goes in here...
	UIView* reorderControl = [cell huntedSubviewWithClassName:@"UITableViewCellReorderControl"];
	[reorderControl setBackgroundColor:[UIColor greenColor]];
  
	//UIView* resizedGripView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(reorderControl.frame), CGRectGetMaxY(reorderControl.frame))];
  UIView* resizedGripView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, CGRectGetMaxX(reorderControl.frame), 20)];
  //[resizedGripView setBackgroundColor:[UIColor redColor]];
	[resizedGripView addSubview :reorderControl];
  // [cell insertSubview:resizedGripView atIndex:0];
	// [cell addSubview:resizedGripView];
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  transform = CGAffineTransformScale(transform, 3.7, 1);
  transform = CGAffineTransformTranslate(transform, -132, 0);
  [resizedGripView setTransform:transform];
  
	
	for(UIImageView* cellGrip in reorderControl.subviews)
	{
		if([cellGrip isKindOfClass:[UIImageView class]])
			[cellGrip setImage:nil];
 	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  // Initializing a custom tableviewcell
  IntervalCellTVC *cell = (IntervalCellTVC *)[tableView dequeueReusableCellWithIdentifier:@"IntervalCell"];
  
  [cell setShowsReorderControl:YES];
  
  // Remove gray table seperators
  [tableView setSeparatorColor:[UIColor clearColor]];
  
  // Configure Cell
  //[cell.lblAction setText:[NSString stringWithFormat:@"%i. %@", indexPath.row+1, values[indexPath.row][0]]];
  [cell.lblNumber setText:[NSString stringWithFormat:@"%i.", indexPath.row+1]];
  [cell.txtAction setText:[NSString stringWithFormat:@"%@", values[indexPath.row][0]]];
  [cell.btnDelete setTag:indexPath.row];
  [cell.btnDelete addTarget:self action:@selector(deleteInterval:) forControlEvents:UIControlEventTouchUpInside];
  [cell.btnEdit setTag:indexPath.row];
  [cell.btnEdit addTarget:self action:@selector(editInterval:) forControlEvents:UIControlEventTouchUpInside];
  
  [cell.txtAction setEnabled:NO];
  [cell.txtDuration setEnabled:NO];
  
  if([values[indexPath.row][0] isEqualToString:@"Repeat"]) {
    [cell.txtDuration setText:[NSString stringWithFormat:@"Steps %@-%@", values[indexPath.row][1], values[indexPath.row][2]]];
  }
  else {
    [cell.imgColor setBackgroundColor:values[indexPath.row][2]];
  
    NSInteger seconds = [values[indexPath.row][1] integerValue];
    NSString *formattedTime = @"";
    
    if(seconds/60 == 0) {
      [cell.txtMinutes setText:@""];
      [cell.txtSeconds setText:[NSString stringWithFormat:@"%@", seconds]];
    }
      formattedTime = [NSString stringWithFormat:@":%02d", seconds];
    else if(seconds/60 >= 60)
      formattedTime = [NSString stringWithFormat:@"%d:%02d:%02d", seconds/3600, (seconds%3600)/60, (seconds%3600)%60];
    else
      formattedTime = [NSString stringWithFormat:@"%d:%02d", seconds/60, seconds%60];
    
    [cell.txtDuration setText:formattedTime];
  }
  
  // Adding an empty footer prevents any cells beyond what's needed
  tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  NSMutableArray *holder = values[sourceIndexPath.row];
  [values removeObjectAtIndex:sourceIndexPath.row];
  [values insertObject:holder atIndex:destinationIndexPath.row];
  [tblIntervals reloadData];
  
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  return YES;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  return UITableViewCellEditingStyleNone;
}


- (IBAction)pushAddWorkout:(id)sender {
  [self performSegueWithIdentifier:@"LandingVC_IntervalVC" sender:nil];
}
- (IBAction)pushAddRepeat:(id)sender {
  [tblIntervals setEditing:YES animated:YES];
}

- (IBAction)pushAddInterval:(id)sender {
  [tblIntervals setEditing:NO animated:NO];
}

- (void) editInterval:(id)sender {
  UIButton *pressed = (UIButton*)sender;
  
  IntervalCellTVC *editing= (IntervalCellTVC*)[tblIntervals cellForRowAtIndexPath:[NSIndexPath indexPathForRow:pressed.tag inSection:0]];
  
  if([pressed.currentTitle isEqual:@"Edit"]) {
    [pressed setTitle:@"Done" forState:UIControlStateNormal];
    [editing.txtDuration setEnabled:YES];
    [editing.txtAction setEnabled:YES];
    [editing.txtAction becomeFirstResponder];
  }
  else {
    [pressed setTitle:@"Edit" forState:UIControlStateNormal];
    [editing.txtDuration setEnabled:NO];
    [editing.txtAction setEnabled:NO];
  }
  
}

- (void) deleteInterval:(id)sender {
  UIButton *pressed = (UIButton*)sender;
  NSLog (@"%i", pressed.tag);
  [values removeObjectAtIndex:pressed.tag];
  NSLog(@"%@", values);
  [tblIntervals reloadData];
}

@end

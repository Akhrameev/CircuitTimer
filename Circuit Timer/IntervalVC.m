//
//  IntervalVC.m
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/2/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import "IntervalVC.h"
@implementation IntervalVC

@synthesize tblIntervals, data, selected_index;

- (void)viewDidLoad
{
  [super viewDidLoad];
  [super setEditing:YES];
  [tblIntervals setEditing:YES];
  
  myGreen = [UIColor colorWithRed:106.0/255.0 green:181.0/255.0 blue:88.0/255.0 alpha:1];
  myRed = [UIColor colorWithRed:216.0/255.0 green:110.0/255.0 blue:110.0/255.0 alpha:1];
  myBlue = [UIColor colorWithRed:99.0/255.0 green:168.0/255.0 blue:229.0/255.0 alpha:1];
  myYellow = [UIColor colorWithRed:216.0/255.0 green:213.0/255.0 blue:110.0/255.0 alpha:1];


  
  i = [selected_index integerValue];
  
  if( i == -1) {
    [data addObject:[[NSMutableArray alloc] initWithObjects:@"New Workout", [[NSMutableArray alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"Workout", @0, myGreen, nil], nil], nil]];
    i = [data count] - 1;
  }
  
  workout_name = data[i][0];
  intervals = data[i][1];
  
  [tblIntervals reloadData];

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
  return [intervals count];
}

//- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//  return 3;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//  return 60;
//}
//
//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//  return [NSString stringWithFormat:@"%02d", row];
//}



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
  
  // Configure Cell
  [cell.lblNumber setText:[NSString stringWithFormat:@"%i.", indexPath.row+1]];
  [cell.txtAction setText:[NSString stringWithFormat:@"%@", intervals[indexPath.row][0]]];
  [cell.btnDelete setTag:indexPath.row];
  [cell.btnDelete addTarget:self action:@selector(deleteInterval:) forControlEvents:UIControlEventTouchUpInside];
  [cell.btnEdit setTag:indexPath.row];
  [cell.btnEdit addTarget:self action:@selector(editInterval:) forControlEvents:UIControlEventTouchUpInside];
  
  [cell.txtAction setEnabled:NO];
  
  if([intervals[indexPath.row][0] isEqualToString:@"Repeat"]) {
    [cell.txtStartStep setText:[NSString stringWithFormat:@"%@", intervals[indexPath.row][1]]];
    [cell.txtEndStep setText:[NSString stringWithFormat:@"%@", intervals[indexPath.row][2]]];
    
    [cell.txtStartStep setEnabled:NO];
    [cell.txtEndStep setEnabled:NO];
    
    [cell.lblColon setHidden:YES];
    [cell.txtMinutes setHidden:YES];
    [cell.txtSeconds setHidden:YES];
  }
  else {
    [cell.imgColor setBackgroundColor:intervals[indexPath.row][2]];
  
    NSInteger seconds = [intervals[indexPath.row][1] integerValue];
    
    if(seconds/60 == 0) {
      [cell.txtMinutes setText:@""];
      [cell.txtSeconds setText:[NSString stringWithFormat:@"%02d", seconds]];
    }
    else {
      [cell.txtMinutes setText:[NSString stringWithFormat:@"%d", seconds/60]];
      [cell.txtSeconds setText:[NSString stringWithFormat:@"%02d", seconds%60]];
    }
    
    [cell.txtMinutes setEnabled:NO];
    [cell.txtSeconds setEnabled:NO];
    
    [cell.lblSteps setHidden:YES];
    [cell.txtStartStep setHidden:YES];
    [cell.txtEndStep setHidden:YES];
  }
  
  // Adding an empty footer prevents any cells beyond what's needed
  tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  return cell;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
  NSMutableArray *holder = intervals[sourceIndexPath.row];
  [intervals removeObjectAtIndex:sourceIndexPath.row];
  [intervals insertObject:holder atIndex:destinationIndexPath.row];
  [self saveChanges];
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

- (IBAction)pushAddRepeat:(id)sender {
  NSMutableArray *new_interval = [[NSMutableArray alloc] initWithObjects:@"Repeat",@1, @1, nil];
  [intervals addObject:new_interval];
  //[tblIntervals setEditing:YES animated:YES];
  [tblIntervals reloadData];
  [self saveChanges];
}

- (IBAction)pushAddInterval:(id)sender {
  NSMutableArray *new_interval = [[NSMutableArray alloc] initWithObjects:@"Workout",@180, myGreen, nil];
  [intervals addObject:new_interval];
  //[tblIntervals setEditing:NO animated:NO];
  [tblIntervals reloadData];
  [self saveChanges];
}

- (void) editInterval:(id)sender {
  UIButton *pressed = (UIButton*)sender;
  NSIndexPath *row = [NSIndexPath indexPathForRow:pressed.tag inSection:0];
  
  IntervalCellTVC *editing= (IntervalCellTVC*)[tblIntervals cellForRowAtIndexPath:row];
  
  
  if([pressed.currentTitle isEqual:@"Edit"]) {
    [pressed setTitle:@"Done" forState:UIControlStateNormal];
    
    if([editing.txtAction.text isEqualToString:@"Repeat"]) {
      [editing.txtStartStep setEnabled:YES];
      [editing.txtEndStep setEnabled:YES];
      [editing.txtStartStep becomeFirstResponder];
    }
    else {
      [editing.txtAction setEnabled:YES];
      [editing.txtMinutes setEnabled:YES];
      [editing.txtSeconds setEnabled:YES];
      [editing.txtAction becomeFirstResponder];
    }
    
    [editing.btnDelete setHidden:NO];
    
    CGRect frame = tblIntervals.frame;
    frame.size.height = 352;
    [UIView animateWithDuration:.3 animations:^{
      [tblIntervals setFrame:frame];
    }];
    
    [tblIntervals scrollToRowAtIndexPath:row atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
  }
  else {
    NSMutableArray *new_interval = [[NSMutableArray alloc] init];
    [pressed setTitle:@"Edit" forState:UIControlStateNormal];
    
    if(![editing.txtAction isEnabled]) {
      [editing.txtStartStep setEnabled:NO];
      [editing.txtEndStep setEnabled:NO];
      
      new_interval = [[NSMutableArray alloc] initWithObjects:
                    editing.txtAction.text,
                    editing.txtStartStep.text,
                    editing.txtEndStep.text,
                    intervals[pressed.tag][2],
                    nil];
    }
    else {
      [editing.txtAction setEnabled:NO];
      [editing.txtMinutes setEnabled:NO];
      [editing.txtSeconds setEnabled:NO];
      
      NSString *action = editing.txtAction.text;
      NSNumber *duration = [NSNumber numberWithInt:[editing.txtMinutes.text integerValue] * 60 + [editing.txtSeconds.text integerValue]];
      
      [new_interval addObject:action];
      [new_interval addObject:duration];
      [new_interval addObject:intervals[pressed.tag][2]];
    }
    
    [editing.btnDelete setHidden:YES];
    
    CGRect frame = tblIntervals.frame;
    frame.size.height = 512;
    [UIView animateWithDuration:.3 animations:^{
      [tblIntervals setFrame:frame];
    }];
    
    [intervals removeObjectAtIndex:pressed.tag];
    [intervals insertObject:new_interval atIndex:pressed.tag];
    
    [self saveChanges];
  }
}

- (void) deleteInterval:(id)sender {
  UIButton *pressed = (UIButton*)sender;
  [intervals removeObjectAtIndex:pressed.tag];
  NSLog(@"%@", intervals);
  [self saveChanges];
  [tblIntervals reloadData];
}

- (void)saveChanges {
  
  [data removeObjectAtIndex:i];
  [data insertObject:[[NSMutableArray alloc] initWithObjects:workout_name, intervals, nil] atIndex:i];
  
  NSData *data_to_save = [NSKeyedArchiver archivedDataWithRootObject:data];
  
  NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
  [save setObject:data_to_save forKey:@"data"];
}

@end

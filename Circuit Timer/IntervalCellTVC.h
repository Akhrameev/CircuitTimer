//
//  IntervalCellTVC.h
//  Circuit Timer
//
//  Created by Ian Forsyth on 11/2/13.
//  Copyright (c) 2013 Ian Forsyth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntervalCellTVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgColor;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@property (weak, nonatomic) IBOutlet UITextField *txtAction;

@property (weak, nonatomic) IBOutlet UITextField *txtEndStep;
@property (weak, nonatomic) IBOutlet UITextField *txtStartStep;
@property (weak, nonatomic) IBOutlet UILabel *lblColon;
@property (weak, nonatomic) IBOutlet UITextField *txtMinutes;
@property (weak, nonatomic) IBOutlet UITextField *txtSeconds;
@property (weak, nonatomic) IBOutlet UILabel *lblSteps;
@end

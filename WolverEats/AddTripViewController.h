//
//  AddTripViewController.h
//  WolverEats
//
//  Created by Miller on 2/27/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTripViewController : UIViewController <UIActionSheetDelegate>
@property (strong, nonatomic)UILabel* addLabel;
@property (strong, nonatomic)UIButton* addTripButton;
@property (strong, nonatomic) UITextField* restaurantText;
@property (strong,nonatomic) UILabel* etaText;
@property (strong, nonatomic) UIButton* etaButton; 


@property UIActionSheet *pickerViewPopup;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)doneClicked;
- (void)setDateClicked; 

@end

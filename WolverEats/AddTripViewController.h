//
//  AddTripViewController.h
//  WolverEats
//
//  Created by Miller on 2/27/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTripViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) UILabel* addLabel;
@property (strong, nonatomic) UIButton* addTripButton;
@property (strong,nonatomic)  UILabel* restLabel;
@property (strong, nonatomic) UITextField* restaurantText;
@property (strong,nonatomic) UILabel* etaText;
@property (strong, nonatomic) UIButton* etaButton;
@property (strong, nonatomic) UIButton* expButton;
@property (strong, nonatomic) UILabel* expLabel;
@property long etaStamp;
@property long expStamp;



@property UIActionSheet *pickerViewPopup;

- (void)addTrip;

@end

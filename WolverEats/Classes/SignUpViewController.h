//
//  SignUpViewController.h
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *fnameText;
@property (weak, nonatomic) IBOutlet UITextField *lnameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

//
//  SignUpViewController.h
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (strong, nonatomic)  UITextField *emailText;
@property (strong, nonatomic)  UITextField *fNameText;
@property (strong, nonatomic)  UITextField *lNameText;
@property (strong, nonatomic)  UITextField *phoneText;
@property (strong, nonatomic)  UIButton *signupButton;

-(void)signUp; 

@end

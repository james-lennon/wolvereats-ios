//
//  SignUpViewController.h
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/3/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (strong, nonatomic)  UITextField *emailText;
@property (strong, nonatomic)  UITextField *fNameText;
@property (strong, nonatomic)  UITextField *lNameText;
@property (strong, nonatomic)  UITextField *phoneText;
@property (strong, nonatomic)  UIButton *signupButton;
@property (strong,nonatomic)   UIButton *backButton;

-(void)signUp;
-(void)back; 

@end

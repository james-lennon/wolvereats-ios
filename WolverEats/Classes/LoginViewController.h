//
//  LoginViewController.h
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/3/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic)  UITextField *emailText;
@property (strong, nonatomic)  UITextField *passwordText;
@property (strong, nonatomic)  UIButton *loginButton;
@property (strong,nonatomic)   UIButton *backButton; 

-(void)back;
@end

//
//  LoginViewController.h
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic)  UITextField *emailText;
@property (strong, nonatomic)  UITextField *passwordText;
@property (strong, nonatomic)  UIButton *loginButton;
@property (strong,nonatomic)   UIButton *backButton; 

-(void)back;
@end

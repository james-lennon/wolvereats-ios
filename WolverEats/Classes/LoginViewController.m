//
//  LoginViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "LoginViewController.h"
#import <MBProgressHUD.h>
#import "Backend.h"

@implementation LoginViewController

- (void)login {
    [_loginButton setEnabled:NO];
    
    NSString *email = _emailText.text, *pass = _passwordText.text;
    [Backend setCredentialsToEmail:email Password:pass];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Backend sendRequestWithURL:@"users/login" Parameters:@{} Callback:^(NSDictionary * data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [_loginButton setEnabled:YES];
        if([data objectForKey:@"error"]){
            NSLog(@"invalid login");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid login"
                                                            message:@"Email or password is incorrect, please try again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            int user_id = [data[@"user_id"] intValue];
            [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"main"] animated:NO completion:nil];
        }
    }];
    
}


-(id)init {
    if ((self = [super init])){
      
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        UITextField *emailText = [[UITextField alloc]initWithFrame: CGRectMake(0, h/5, 2w/3, 30)];
        emailText.placeholder = @"email";
        emailText.backgroundColor = [UIColor whiteColor];
        emailText.textColor = [UIColor blackColor];
        emailText.borderStyle = UITextBorderStyleRoundedRect;
        emailText.textAlignment = UITextAlignmentLeft;
        emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
        emailText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:emailText];
        
        UITextField *passwordText = [[UITextField alloc]initWithFrame: CGRectMake(0, h/5 + 100, 2w/3, 30)];
        passwordText.placeholder = @"password";
        passwordText.backgroundColor = [UIColor whiteColor];
        passwordText.textColor = [UIColor blackColor];
        passwordText.borderStyle = UITextBorderStyleRoundedRect;
        passwordText.textAlignment = UITextAlignmentLeft;
        passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
        passwordText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:passwordText];
        
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        loginButton.frame = CGRectMake(0, 3*h/5, w, 100);
        [loginButton setTitle:@"login" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginButton];
    }
    return self;
}



@end

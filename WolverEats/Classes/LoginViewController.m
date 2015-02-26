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
#import "MainTabBarViewController.h"

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
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
}


-(id)init {
    if ((self = [super init])){
      
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        _emailText = [[UITextField alloc] initWithFrame: CGRectMake(w/5, h/4, 3*w/5, 30)];
        _emailText.placeholder = @"email";
        _emailText.backgroundColor = [UIColor whiteColor];
        _emailText.textColor = [UIColor blackColor];
        _emailText.borderStyle = UITextBorderStyleRoundedRect;
        _emailText.textAlignment = NSTextAlignmentLeft;
        _emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_emailText];
        
        _passwordText = [[UITextField alloc] initWithFrame: CGRectMake(w/5, h/4 + 50, 3*w/5, 30)];
        _passwordText.placeholder = @"password";
        _passwordText.backgroundColor = [UIColor whiteColor];
        _passwordText.textColor = [UIColor blackColor];
        _passwordText.borderStyle = UITextBorderStyleRoundedRect;
        _passwordText.textAlignment = NSTextAlignmentLeft;
        _passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_passwordText];
        
        
        _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginButton.frame = CGRectMake(0, 3*h/5, w, 100);
        [_loginButton setTitle:@"login" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
    }
    return self;
}

-(void)dismissKeyboard {
    [_emailText resignFirstResponder];
    [_passwordText resignFirstResponder];
    
}



@end

//
//  SignUpViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <MBProgressHUD.h>
#import "SignUpViewController.h"
#import "Backend.h"

@implementation SignUpViewController


-(id)init {
    if ((self = [super init])){
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        _fNameText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4, 3*w/5, 30)];
        _fNameText.placeholder = @"First Name";
        _fNameText.backgroundColor = [UIColor whiteColor];
        _fNameText.textColor = [UIColor blackColor];
        _fNameText.borderStyle = UITextBorderStyleRoundedRect;
        _fNameText.textAlignment = NSTextAlignmentLeft;
        _fNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _fNameText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview: _fNameText];
        
        _lNameText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4 + 50, 3*w/5, 30)];
        _lNameText.placeholder = @"Last Name";
        _lNameText.backgroundColor = [UIColor whiteColor];
        _lNameText.textColor = [UIColor blackColor];
        _lNameText.borderStyle = UITextBorderStyleRoundedRect;
        _lNameText.textAlignment = NSTextAlignmentLeft;
        _lNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _lNameText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_lNameText];
        
        _emailText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4 + 100, 3*w/5, 30)];
        _emailText.placeholder = @"Email";
        _emailText.backgroundColor = [UIColor whiteColor];
        _emailText.textColor = [UIColor blackColor];
        _emailText.borderStyle = UITextBorderStyleRoundedRect;
        _emailText.textAlignment = NSTextAlignmentLeft;
        _emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_emailText];
        
        _phoneText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4 + 150, 3*w/5, 30)];
        _phoneText.placeholder = @"Phone Number";
        _phoneText.backgroundColor = [UIColor whiteColor];
        _phoneText.textColor = [UIColor blackColor];
        _phoneText.borderStyle = UITextBorderStyleRoundedRect;
        _phoneText.textAlignment = NSTextAlignmentLeft;
        _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_phoneText];
        
        _signupButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _signupButton.frame = CGRectMake(0, 3*h/5, w, 100);
        [_signupButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [_signupButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_signupButton];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _backButton.frame = CGRectMake(0, 3*h/5 + 50, w, 100);
        [_backButton setTitle:@"Back" forState:UIControlStateNormal];
        [_backButton addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
    }
    return self;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissKeyboard {
    [_fNameText resignFirstResponder];
    [_lNameText resignFirstResponder];
    [_emailText resignFirstResponder];
    [_phoneText resignFirstResponder];
}


- (void)signUp {
    [_signupButton setEnabled:NO];
    
    NSString* email = _emailText.text, *fname = _fNameText.text, *lname = _lNameText.text, *phone = _phoneText.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Backend sendRequestWithURL:@"users/add" Parameters:@{@"email":email, @"firstname":fname, @"lastname":lname, @"phone":phone} Callback:^(NSDictionary * data) {
        [_signupButton setEnabled:YES];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([data objectForKey:@"error"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Already In Use"
                                                            message:[NSString stringWithFormat:@"An account already exists with the email '%@'.", email]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                            message:@"Please check your email to verify your account."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            [alert show];
            [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] animated:NO completion:nil];
        }
    }];
}



@end

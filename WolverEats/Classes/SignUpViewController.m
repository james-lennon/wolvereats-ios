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

- (IBAction)signUp:(id)sender {
    [_signupButton setEnabled:NO];
    
    NSString* email = _emailText.text, *fname = _fnameText.text, *lname = _lnameText.text, *phone = _phoneText.text;
    
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

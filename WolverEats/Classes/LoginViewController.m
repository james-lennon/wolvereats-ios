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

- (IBAction)login:(id)sender {
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


@end

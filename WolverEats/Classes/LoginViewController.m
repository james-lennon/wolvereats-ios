//
//  LoginViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "LoginViewController.h"
#import "Backend.h"

@implementation LoginViewController

- (IBAction)login:(id)sender {
    NSString *email = _emailText.text, *pass = _passwordText.text;
    [Backend setCredentialsToEmail:email Password:pass];
    [Backend sendRequestWithURL:@"users/login" Parameters:@{} Callback:^(NSDictionary * data) {
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
- (IBAction)showCreateAccount:(id)sender {
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signup"] animated:NO completion:nil];
}


@end

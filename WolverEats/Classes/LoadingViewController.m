//
//  LoadingViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "LoadingViewController.h"
#import "Backend.h"

@implementation LoadingViewController

-(void)viewDidAppear:(BOOL)animated{
    BOOL success = [Backend loadCredentials];
    if(success){
        [Backend sendRequestWithURL:@"users/login" Parameters:@{} Callback:^(NSDictionary * resp) {
            int user_id = [resp[@"user_id"] intValue];
            NSLog(@"user id = %d", user_id);
            [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"main"] animated:NO completion:nil];
        }];
    }else{
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] animated:NO completion:nil];
    }
}

@end

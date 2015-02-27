//
//  LoadingViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "LoadingViewController.h"
#import "Backend.h"
#import "WelcomeViewController.h"
#import "TripsListViewController.h"
#import "ProfileViewController.h"
#import "NoConnectionViewController.h"


@implementation LoadingViewController

-(void)viewDidAppear:(BOOL)animated{
    
    BOOL success = [Backend loadCredentials];
    if(success){
        [Backend sendRequestWithURL:@"users/login" Parameters:@{} Callback:^(NSDictionary * resp) {
            int user_id = [resp[@"user_id"] intValue];
            
        } Failure:^{
            NoConnectionViewController *noConnectionController = [[NoConnectionViewController alloc] init];
            [self presentViewController:noConnectionController animated:NO completion:nil];
            
        }];
    }else{
        WelcomeViewController *welcomeController = [[WelcomeViewController alloc] init];
        [self presentViewController:welcomeController animated:NO completion:nil];
    }
    
    
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,77,21)];
    loadingLabel.center = CGPointMake(w/2, h/2);
    loadingLabel.text = @"Loading...";
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    //[self.view addSubview:loadingLabel];

}

- (id) init {
    if ((self = [super init])) {

        
    }
    return self;
}



@end

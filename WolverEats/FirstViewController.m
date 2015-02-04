//
//  FirstViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "FirstViewController.h"
#import "Backend.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [Backend setCredentialsToEmail:@"aron@aron.com" Password:@"test"];
    BOOL good = [Backend loadCredentials];
    NSLog(@"loaded: %d", good);
    
    NSDictionary* data = @{};
    [Backend sendRequestWithURL:@"users/login" Parameters:data Callback:^(NSDictionary * resp) {
        NSLog(@"working");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

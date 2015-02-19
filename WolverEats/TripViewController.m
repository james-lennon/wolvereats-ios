//
//  TripViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/5/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "TripViewController.h"
#import "TripsListViewController.h"
#import "Backend.h"

@interface TripViewController ()

@end

@implementation TripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tripLabel.text = _tripData[@"restaurant_name"];
    
    int eta = [_tripData[@"eta"] intValue];
    int hours = (eta % (24*3600))/(3600);
    int minutes = (eta % (3600))/(60);
    
    _etaLabel.text = [NSString stringWithFormat:@"%d:%02d", hours, minutes];
    int expiration = [_tripData[@"expiration"] intValue];
    int hours1 = (expiration % (24*3600))/(3600);
    int minutes1 = (expiration % (3600))/(60);
    
    NSString *driverID = _tripData[@"driver_id"];
    
    _expLabel.text = [NSString stringWithFormat:@"%d:%02d", hours1, minutes1];
    
    NSDictionary *userDic = @{@"user_id" : driverID};
    [Backend sendRequestWithURL:@"users/get" Parameters:userDic Callback:^(NSDictionary * data) {
        _userData = data[@"user"];
    }];
    
     NSString* firstName = _userData[@"first_name"];
     NSString* lastName = _userData[@"last_name"];
    NSLog(@"%@ %@",firstName, lastName);
     
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)placeOrder:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

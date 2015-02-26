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
#import "OrderViewController.h"

@interface TripViewController ()

@end

@implementation TripViewController

- (id)initWithData:(NSDictionary *)tripData {
    if ((self = [super init])) {
        
    _tripData = tripData;
    
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
    
    UILabel *tripLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, w, 100)];
    tripLabel.text = _tripData[@"restaurant_name"];
    tripLabel.textAlignment = NSTextAlignmentCenter;
    tripLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:tripLabel];
    
    
    UILabel *etaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, w/2, w, 100)];
    int eta = [_tripData[@"eta"] intValue];
    int hours = (eta % (24*3600))/(3600);
    int minutes = (eta % (3600))/(60);
    etaLabel.textAlignment = NSTextAlignmentCenter;
    NSString *etaString = @"Arrive By: ";
    etaLabel.text = [NSString stringWithFormat:@"%@ %d:%02d",etaString, hours, minutes];
    [self.view addSubview:etaLabel];
    
    
    UILabel *expLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, w/2 + 100, w, 100)];
    int expiration = [_tripData[@"expiration"] intValue];
    int hours1 = (expiration % (24*3600))/(3600);
    int minutes1 = (expiration % (3600))/(60);
    expLabel.text = [NSString stringWithFormat:@" %d:%02d", hours1, minutes1];
    [self.view addSubview:expLabel];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, w, 100)];
    NSString *driverID = _tripData[@"driver_id"];

    NSDictionary *userDic = @{@"user_id" : driverID};
    [Backend sendRequestWithURL:@"users/get" Parameters:userDic Callback:^(NSDictionary * data) {
        _userData = data[@"user"];
        NSString* firstName = _userData[@"first_name"];
        NSString* lastName = _userData[@"last_name"];
        
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }];
    [self.view addSubview:nameLabel];
    
    
    _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _orderButton.frame = CGRectMake(0, 3*h/5 + 50, w, 100);
    [_orderButton setTitle:@"Place Order" forState:UIControlStateNormal];
    [_orderButton addTarget: self action:@selector(placeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_orderButton];

    
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)placeOrder: {
    OrderViewController *orderController = [[OrderViewController alloc] init];
    orderController.tripData = _tripData;
    orderController.userData = _userData; 
    [self presentViewController:orderController animated:YES completion:nil];
   
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

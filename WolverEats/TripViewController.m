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
        
    self.title = _tripData[@"restuarant_name"]; 
    _tripData = tripData;
    
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
    
    _tripLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5, w, 100)];
    _tripLabel.text = _tripData[@"restaurant_name"];
    _tripLabel.textAlignment = NSTextAlignmentCenter;
    _tripLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:_tripLabel];
    
    UILabel *from = [[UILabel alloc]initWithFrame:CGRectMake(w/4, h/5+75, w/2, 40)];
    from.text = @"from";
    from.font = [UIFont systemFontOfSize:20];
    from.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:from]; 
    
    
    _expLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/4, h/2, w/2, 50)];
    int expiration = [_tripData[@"expiration"] intValue];
    int hours1 = (expiration % (24*3600))/(3600);
    int minutes1 = (expiration % (3600))/(60);
    NSString *expString = @"Order By: ";
    _expLabel.font = [UIFont systemFontOfSize:20];
    _expLabel.text = [NSString stringWithFormat:@"%@ %d:%02d", expString, hours1, minutes1];
    _expLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_expLabel];
        
    _etaLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/4, h/2 +50, w/2, 50)];
    int eta = [_tripData[@"eta"] intValue];
    int hours = (eta % (24*3600))/(3600);
    int minutes = (eta % (3600))/(60);
    _etaLabel.textAlignment = NSTextAlignmentCenter;
    _etaLabel.font = [UIFont systemFontOfSize:20];
    NSString *etaString = @"Arrive By: ";
    _etaLabel.text = [NSString stringWithFormat:@"%@ %d:%02d",etaString, hours, minutes];
    [self.view addSubview:_etaLabel];
    
    
   
    
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5+110 , w, 50)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:30];
    NSString *driverID = _tripData[@"driver_id"];

    NSDictionary *userDic = @{@"user_id" : driverID};
    [Backend sendRequestWithURL:@"users/get" Parameters:userDic Callback:^(NSDictionary * data) {
        _userData = data[@"user"];
        NSString* firstName = _userData[@"first_name"];
        NSString* lastName = _userData[@"last_name"];
        
        _nameLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }];
    [self.view addSubview:_nameLabel];
    
    
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

- (void)placeOrder {
    OrderViewController *orderController = [[OrderViewController alloc] init];
    orderController.tripData = _tripData;
    orderController.userData = _userData;
    
    [self.navigationController pushViewController:orderController animated:YES];
   
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

//
//  MyTripsListViewController.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import "MyTripsListViewController.h"
#import "MyTripsListTableViewCell.h"
#import "Backend.h"
#import <UIScrollView+SVPullToRefresh.h>
#import "TripViewController.h"
#import "EmptyTripViewController.h"
#import "MyTripViewController.h"
#import "OldTripOrdersTableViewController.h"

@interface MyTripsListViewController ()

@end

@implementation MyTripsListViewController

- (id) init {
    if ((self = [super init])) {
        
        self.title = @"My Trips";
        self.tabBarItem.image = [UIImage imageNamed:@"MyTripsTab.png"];

    
        
        [self.tableView registerClass:[MyTripsListTableViewCell class] forCellReuseIdentifier:@"MyTripCell"];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                                action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];
        
        self.clearsSelectionOnViewWillAppear = YES;

    }
    return self;
    
}
- (void)refresh {
    __weak MyTripsListViewController *weakself = self;
        [Backend sendRequestWithURL:@"trips/get_user_trips" Parameters:@{} Callback:^(NSDictionary * data) {
            weakself.activeTripsData = data[@"active_trips"];
            weakself.inactiveTripsData = data[@"inactive_trips"];
            [weakself.refreshControl endRefreshing];
            [weakself.tableView reloadData];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Active Trips";
    else{
        return @"Old Trips";
    }
}


- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0)
        return [_activeTripsData count];
    else {
        return [_inactiveTripsData count];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTripsListTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyTripCell"];
   
    NSArray *arr = indexPath.section == 0 ? _activeTripsData : _inactiveTripsData;
    NSDictionary* trip = arr[indexPath.row];

    cell.restaurant = trip[@"restaurant_name"];
    cell.tripStatus = indexPath.section == 0 ? @"active" : @"inactive";
    cell.eta = [trip[@"eta"] intValue];
    cell.numOrders = [trip[@"order_count"] intValue];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        NSDictionary* trip = _activeTripsData[indexPath.row];
       /* NSString* tripId = trip[@"trip_id"];
        [Backend sendRequestWithURL:@"orders/get_trip_orders" Parameters:@{@"trip_id":tripId} Callback:^(NSDictionary * data) {
            _orders = data;
            
            if ([_orders count] == 0){
                EmptyTripViewController *vc = [[EmptyTripViewController alloc]initWithData:trip];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            else
            { */
        
        MyTripViewController *vc = [[MyTripViewController alloc]initWithData:trip];
        [self.navigationController pushViewController:vc animated:YES];

        
        
        //}];
    }
    else
    {
    NSDictionary* trip = _inactiveTripsData[indexPath.row];
    OldTripOrdersTableViewController *vc = [[OldTripOrdersTableViewController alloc] initWithData:trip];
    [self.navigationController pushViewController:vc animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    
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

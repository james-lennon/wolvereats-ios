//
//  TripsListViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/4/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "TripsListViewController.h"
#import "TripViewController.h"
#import "Backend.h"
#import <UIScrollView+SVPullToRefresh.h>


@interface TripsListViewController ()

@end

@implementation TripsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        // prepend data to dataSource, insert cells at top of table view
        // call [tableView.pullToRefreshView stopAnimating] when done
        [Backend sendRequestWithURL:@"trips/get_all_active_trips" Parameters:@{} Callback:^(NSDictionary * data) {
            _tripsData = [data objectForKey:@"trips"];
            [_tableView.pullToRefreshView stopAnimating];
            [_tableView reloadData];
        }];
    }];
    [_tableView triggerPullToRefresh];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tripsData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"tripCell"];
    NSDictionary* trip = _tripsData[indexPath.row];
    
    UILabel* restaurant = (UILabel*)[cell viewWithTag:101];
    restaurant.text = trip[@"restaurant_name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* trip = _tripsData[indexPath.row];
    TripViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"trip"];
    vc.tripData = trip;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

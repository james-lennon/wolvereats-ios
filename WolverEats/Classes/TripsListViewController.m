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
#import "NSDate+Helper.h"
#import "TripsListTableViewCell.h"
#import "AddTripViewController.h"


@interface TripsListViewController ()

@end

@implementation TripsListViewController

- (id) init {
    if ((self = [super init])) {
        
        self.title = @"Trips";
        self.tabBarItem.image = [UIImage imageNamed:@"TripsTab.png"];

        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTrip)];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                                action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];
        
        [self.tableView registerClass:[TripsListTableViewCell class] forCellReuseIdentifier:@"TripCell"];
        
    }
    
    return self;
}

- (void)refresh {
    __weak TripsListViewController *weakself = self;
    [Backend sendRequestWithURL:@"trips/get_all_active_trips" Parameters:@{} Callback:^(NSDictionary * data) {
            weakself.tripsData = [data objectForKey:@"trips"];
        [weakself.refreshControl endRefreshing];
        [weakself.tableView reloadData];
    }];
}



- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

-(void)addTrip
{
    AddTripViewController *addTripController = [[AddTripViewController alloc] init];
    [self.navigationController pushViewController:addTripController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [_tripsData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TripsListTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TripCell"];
    [cell setNeedsUpdateConstraints];
    
    NSDictionary* trip = _tripsData[indexPath.row];
    cell.restaurant = trip[@"restaurant_name"];
    cell.eta = [trip[@"eta"] intValue];
    
    NSString* firstName = trip[@"first_name"];
    NSString* lastName = trip[@"last_name"];
    cell.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    //change when James writes prof URL code in server
    NSURL *profURL = [NSURL URLWithString:@"http://placehold.it/40x40"];

    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        NSData *image = [[NSData alloc] initWithContentsOfURL:profURL];
        
        
        //this will set the image when loading is finished
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.profView.image = [UIImage imageWithData:image];
        });
    });
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* trip = _tripsData[indexPath.row];
    TripViewController *vc = [[TripViewController alloc] initWithData:trip];
    [self.navigationController pushViewController:vc animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

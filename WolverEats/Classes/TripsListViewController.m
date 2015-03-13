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

        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
        //NSMutableArray *navButtons = [[NSMutableArray alloc] init];
        
        //UIBarButtonItem *plusBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus49.png"] style:UIBarButtonItemStylePlain target:self action:@selector(addTrip)];
        //[navButtons addObject:plusBtn];
        //[self.navigationItem setRightBarButtonItems:navButtons animated:NO];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTrip)];

        //[_backButton addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIEdgeInsets inset = UIEdgeInsetsMake(60, 0, 0, 0);
        _tableView.contentInset = inset;
        _tableView.scrollIndicatorInsets = inset;
        
        [_tableView registerClass:[TripsListTableViewCell class] forCellReuseIdentifier:@"TripCell"];
        
        [self.view addSubview:_tableView];
        
        
        [_tableView addPullToRefreshWithActionHandler:^{
            // prepend data to dataSource, insert cells at top of table view
            // call [tableView.pullToRefreshView stopAnimating] when done
            [Backend sendRequestWithURL:@"trips/get_all_active_trips" Parameters:@{} Callback:^(NSDictionary * data) {
                _tripsData = [data objectForKey:@"trips"];
                [_tableView.pullToRefreshView stopAnimating];
                [_tableView reloadData];
            }];
        }];

    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView triggerPullToRefresh];
    //[self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
  
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
    
    TripsListTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"TripCell"];
    [cell setNeedsUpdateConstraints];
    
    NSDictionary* trip = _tripsData[indexPath.row];
    
    NSString *restaurantString = trip[@"restaurant_name"];
    cell.restaurantLabel.text = restaurantString;
    
    int eta = [trip[@"eta"] intValue];
    NSDate *etaDate = [NSDate dateWithTimeIntervalSince1970:eta];
    NSString *etaString = [NSDate stringForDisplayFromDate:etaDate prefixed:NO alwaysDisplayTime:NO];
    //NSString *etaString = [NSDate stringFromDate:etaDate withFormat:@"hh:mm"];
    cell.etaLabel.text = etaString;
    
    NSString *driverID = trip[@"driver_id"];
    
    NSDictionary *userDic = @{@"user_id" : driverID};
    [Backend sendRequestWithURL:@"users/get" Parameters:userDic Callback:^(NSDictionary * data) {
        NSDictionary* userData = data[@"user"];
        NSString* firstName = userData[@"first_name"];
        NSString* lastName = userData[@"last_name"];
        
        cell.driverName.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }];
    
    
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
}

@end

//
//  MyTripViewController.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "MyTripViewController.h"
#import "MyTripTableViewCell.h"
#import <UIScrollView+SVPullToRefresh.h>
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>

@interface MyTripViewController ()

@end

@implementation MyTripViewController

- (id)initWithData:(NSDictionary *)tripData {
    if ((self = [super init])) {
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tripData = tripData;
        self.title = _tripData[@"restaurant_name"]; 
        
        
        [self.tableView registerClass:[MyTripTableViewCell class] forCellReuseIdentifier:@"MyTripCell"];
        self.clearsSelectionOnViewWillAppear = YES;

        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                                action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];
                
    }
    return self;
}

- (void)refresh {
    
    __weak MyTripViewController *weakself = self;
    NSString *tripID = _tripData[@"trip_id"];
    
    [Backend sendRequestWithURL:@"orders/get_trip_orders" Parameters:@{@"trip_id" : tripID} Callback:^(NSDictionary * data) {
        _pendingOrderData = data[@"pending"];
        _acceptedOrderData = data[@"accepted"];
        _rejectedOrderData = data[@"rejected"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.refreshControl endRefreshing];
            [weakself.tableView reloadData];
        });
    }];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Pending Orders";
    }
    else if (section == 1)
    {
        return @"Accepted Orders";
    }
    else
    {
        return @"Rejected Orders";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
    {
        return [_pendingOrderData count];
    }
    else if (section == 1)
    {
        return [_acceptedOrderData count];
    }
    else
    {
        return [_rejectedOrderData count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary* order;
    if (indexPath.section == 0)
    {
        order = _pendingOrderData[indexPath.row];
    }
    else if (indexPath.section == 1) {
        order = _acceptedOrderData[indexPath.row];
    }
    else
    {
        order = _rejectedOrderData[indexPath.row];
    }
    
    NSString *orderText = order[@"order_text"];
    return [MyTripTableViewCell cellHeightForOrder:orderText];
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTripTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyTripCell"];
    cell.delegate = self;
    cell.cellIndex = indexPath.row;
    NSDictionary* order;
    if (indexPath.section == 0)
    {
    order = _pendingOrderData[indexPath.row];
    }
    else if (indexPath.section == 1) {
        order = _acceptedOrderData[indexPath.row];
    }
    else
    {
        order = _rejectedOrderData[indexPath.row];
    }
    NSString* firstName = order[@"first_name"];
    NSString* lastName = order[@"last_name"];
    cell.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    NSString *orderText = order[@"order_text"];
    cell.order = orderText;
    cell.orderID = [order[@"order_id"] intValue];
    cell.state = [order[@"state"] intValue];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didClickOnAcceptOrder:(NSInteger)cellIndex
{
    /*
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are you sure?"
                                                   message:@"Once you accept the order, you can't change your mind."
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Okay", nil];
    alert.tag = 0;
    [alert show];
     */
    
    NSDictionary* order = _pendingOrderData[cellIndex];
    int orderInt = [order[@"order_id"] intValue];
    NSNumber* orderID = [NSNumber numberWithInt:orderInt];
    [Backend sendRequestWithURL:@"orders/accept_order"Parameters:@{@"order_id":orderID} Callback:^(NSDictionary * data){
    
        if([data objectForKey:@"error"]){
            NSLog(@"invalid login");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Failed"
                                                            message:@"Your request did not process, please try again later."
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            alert.tag = 2;
            [alert show];
        }
        
        NSDictionary *order = _pendingOrderData[cellIndex];
        NSMutableArray *newarray = [NSMutableArray arrayWithArray:_acceptedOrderData];
        [newarray insertObject:order atIndex:0];
        _acceptedOrderData = newarray;

        NSMutableArray *newparray = [NSMutableArray arrayWithArray:_pendingOrderData];
        [newparray removeObjectAtIndex:cellIndex];
        _pendingOrderData = newparray;
        
        MyTripTableViewCell *cell = (MyTripTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0]];
        cell.state = 1;
        
        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0] toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        
    }];
    
    
    
}


-(void)didClickOnDeclineOrder:(NSInteger)cellIndex
{
    NSDictionary* order = _pendingOrderData[cellIndex];
    int orderInt = [order[@"order_id"] intValue];
    NSNumber* orderID = [NSNumber numberWithInt:orderInt];
    [Backend sendRequestWithURL:@"orders/reject_order" Parameters:@{@"order_id":orderID} Callback:^(NSDictionary * data) {
     
        if([data objectForKey:@"error"]){
            NSLog(@"invalid login");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Failed"
                                                            message:@"Your request did not process, please try again later."
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            alert.tag = 2;
            [alert show];
        }
        
        NSDictionary *order = _pendingOrderData[cellIndex];
        NSMutableArray *rejected = [NSMutableArray arrayWithArray:_rejectedOrderData];
        [rejected insertObject:order atIndex:0];
        _rejectedOrderData = rejected;
        
        NSMutableArray *pending = [NSMutableArray arrayWithArray:_pendingOrderData];
        [pending removeObjectAtIndex:cellIndex];
        _pendingOrderData = pending;
        
        MyTripTableViewCell *cell = (MyTripTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0]];
        cell.state = 2;
        
        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0] toIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];

    
    }];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

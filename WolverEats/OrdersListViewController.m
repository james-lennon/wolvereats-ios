//
//  OrdersListViewController.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "OrdersListViewController.h"
#import "NSDate+Helper.h"
#import "Backend.h"
#import "OrderListTableViewCell.h"

@interface OrdersListViewController ()

@end

@implementation OrdersListViewController


- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

- (id) init {
    if ((self = [super init])) {
        
        self.title = @"My Orders";
        self.tabBarItem.image = [UIImage imageNamed:@"OrderTab.png"];
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.tableView registerClass:[OrderListTableViewCell class] forCellReuseIdentifier:@"MyOrderCell"];
    
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                                action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];
        
        self.clearsSelectionOnViewWillAppear = YES;

    }
    return self;
}

- (void)refresh {
    [Backend sendRequestWithURL:@"orders/get_all_customer_orders" Parameters:@{} Callback:^(NSDictionary * data) {
        _acceptedOrdersData = data[@"accepted_orders"];
        _pendingOrdersData = data[@"pending_orders"];
        _completedOrdersData = data[@"completed_orders"];
        
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Pending Orders";
    else if(section==1)
        return @"Accepted Orders";
    else
        return @"Completed Orders";
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr;
    if(indexPath.section == 0) {
        arr = _pendingOrdersData;
    }
    else if(indexPath.section==1) {
        arr = _acceptedOrdersData;
    }
    else {
        arr = _completedOrdersData;
    }
    
    NSDictionary* order = arr[indexPath.row];
    NSString *orderText = order[@"order_text"];

    return [OrderListTableViewCell cellHeightForOrder:orderText];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [_pendingOrdersData count];
    }
    else if (section == 1) {
        return [_acceptedOrdersData count];
    }
    else {
        return [_completedOrdersData count];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyOrderCell"];
    
    NSArray *arr;
    if(indexPath.section == 0) {
        arr = _pendingOrdersData;
    }
    else if(indexPath.section==1) {
        arr = _acceptedOrdersData;
    }
    else {
        arr = _completedOrdersData;
    }
    
    NSDictionary* order = arr[indexPath.row];
    
    cell.restaurant = order[@"restaurant_name"];
    cell.orderText = order[@"order_text"];
    cell.orderState = [order[@"state"] intValue]; 
    
    return cell;
}

@end

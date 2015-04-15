//
//  OldTripOrdersTableViewController.m
//  WolverEats
//
//  Created by Miller on 4/14/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "OldTripOrdersTableViewController.h"
#import <UIScrollView+SVInfiniteScrolling.h>
#import "Backend.h"
#import "OldTripOrderTableViewCell.h"


@interface OldTripOrdersTableViewController ()

@end

@implementation OldTripOrdersTableViewController

- (id)initWithData:(id)tripData{
    if ((self = [super init])){
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tripData = tripData;
        self.title = _tripData[@"restaurant_name"];
        
        [self.tableView registerClass: [OldTripOrderTableViewCell class] forCellReuseIdentifier:@"MyOldTripCell" ];
        self.clearsSelectionOnViewWillAppear = YES;
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self
                                action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];
    }
    return self;
    
}

-(void)refresh{
    __weak OldTripOrdersTableViewController *weakself = self;
    NSString *tripID = _tripData[@"trip_id"];
    
    [Backend sendRequestWithURL:@"orders/get_trip_orders" Parameters:@{@"trip_id" : tripID} Callback:^(NSDictionary * data) {
        _acceptedOrderData = data[@"accepted"];
        _rejectedOrderData = data[@"rejected"];
        [weakself.refreshControl endRefreshing];
        [weakself.tableView reloadData];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self refresh];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (section == 0)
  {
      return [_acceptedOrderData count];
  }
    else
  {
      return [_rejectedOrderData count];
  }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section == 0)
    {
        return @"Accepted Orders";
    }
    else
    {
        return @"Rejected Orders";
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OldTripOrderTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyOldTripCell" forIndexPath:indexPath];
    //cell.delegate = self;
    NSDictionary* order;
    if (indexPath.section == 0)
    {
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
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

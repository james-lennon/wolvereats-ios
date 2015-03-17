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

@interface MyTripViewController ()

@end

@implementation MyTripViewController

- (id)initWithData:(NSDictionary *)tripData {
    if ((self = [super init])) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIEdgeInsets inset = UIEdgeInsetsMake(60, 0, 0, 0);
        _tableView.contentInset = inset;
        _tableView.scrollIndicatorInsets = inset;
        [_tableView registerClass:[MyTripTableViewCell class] forCellReuseIdentifier:@"MyTripCell"];
        
        [self.view addSubview:_tableView];
        
        NSString *tripID = tripData[@"trip_id"];
        
        [_tableView addPullToRefreshWithActionHandler:^{
            // prepend data to dataSource, insert cells at top of table view
            // call [tableView.pullToRefreshView stopAnimating] when done
            [Backend sendRequestWithURL:@"orders/get_trip_orders" Parameters:@{@"trip_id" : tripID} Callback:^(NSDictionary * data) {
                _tripOrderData = data;
                
                [_tableView.pullToRefreshView stopAnimating];
                [_tableView reloadData];
            }];
        }];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"orders";
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTripTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"MyTripCell"];
    NSDictionary* order = _tripOrderData[indexPath.row];
    
    /*cell.restaurant = trip[@"restaurant_name"];
    cell.tripStatus = indexPath.section == 0 ? @"active" : @"inactive";
    cell.eta = [trip[@"expiration"] intValue];
    cell.numOrders = [trip[@"order_count"] intValue];
    */
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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

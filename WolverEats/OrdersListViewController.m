//
//  OrdersListViewController.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "OrdersListViewController.h"
#import <UIScrollView+SVPullToRefresh.h>
#import "NSDate+Helper.h"
#import "Backend.h"
#import "OrderListTableViewCell.h"

@interface OrdersListViewController ()

@end

@implementation OrdersListViewController


- (void)viewWillAppear:(BOOL)animated {
    [_tableView triggerPullToRefresh];
    //[self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height) animated:YES];
    
}

- (id) init {
    if ((self = [super init])) {
        
        self.title = @"My Orders";
        self.tabBarItem.image = [UIImage imageNamed:@"OrderTab.png"];
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        UIEdgeInsets inset = UIEdgeInsetsMake(60,0,0,0);
        _tableView.contentInset = inset;
        _tableView.scrollIndicatorInsets = inset;
        
        [_tableView registerClass:[OrderListTableViewCell class] forCellReuseIdentifier:@"MyOrderCell"];
        [self.view addSubview:_tableView];
    
        
        [_tableView addPullToRefreshWithActionHandler:^{
            // prepend data to dataSource, insert cells at top of table view
            // call [tableView.pullToRefreshView stopAnimating] when done
            [Backend sendRequestWithURL:@"orders/get_all_customer_orders" Parameters:@{} Callback:^(NSDictionary * data) {
                NSLog(@"get_all_customer_orders:  %@", data);

                _activeOrdersData = data[@"active_orders"];
                _inactiveOrdersData = data[@"inactive_orders"];
            
                
                [_tableView.pullToRefreshView stopAnimating];
                [_tableView reloadData];
            }];
        }];
        
    }
    return self;
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
        return @"Active Orders";
    else{
        return @"Old Orders";
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
        return [_activeOrdersData count];
    else {
        return [_inactiveOrdersData count];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListTableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:@"MyOrderCell"];
    
    NSArray *arr = indexPath.section == 0 ? _activeOrdersData : _inactiveOrdersData;
    NSDictionary* order = arr[indexPath.row];
    
    cell.restaurant = order[@"restaurant_name"];
    cell.orderText = order[@"order_text"];
    cell.orderState = [order[@"state"] intValue]; 
    //cell.orderStatus = indexPath.section == 0 ? @"active" : @"inactive";
    //cell.eta = [trip[@"expiration"] intValue];
    //cell.numOrders = [trip[@"order_count"] intValue];
    
    return cell;
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

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
        
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tripData = tripData;
        
        
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
        _tripOrderData = data[@"orders"];
        [weakself.refreshControl endRefreshing];
        [weakself.tableView reloadData];

    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Orders";
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary* order = _tripOrderData[indexPath.row];
    NSString *orderText = order[@"order_text"];
    CGSize constraint = CGSizeMake(320 - (10 * 2), 2000);
    CGRect textRect = [orderText boundingRectWithSize:constraint
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}
                                         context:nil];
    CGFloat height = MAX(ceil(textRect.size.height), 44.0f);
    return height + (16 * 2);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tripOrderData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTripTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MyTripCell"];
    NSDictionary* order = _tripOrderData[indexPath.row];
    
    NSString* firstName = order[@"first_name"];
    NSString* lastName = order[@"last_name"];
    cell.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    NSString *orderText = order[@"order_text"];
    cell.order = orderText;
    
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

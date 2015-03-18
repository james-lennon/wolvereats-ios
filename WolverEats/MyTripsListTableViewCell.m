//
//  MyTripListViewControllerCell.m
//  WolverEats
//
//  Created by Miller on 3/10/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "MyTripsListTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+Helper.h"

@interface MyTripsListTableViewCell ()

@end

@implementation MyTripsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        _restaurantLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
        _restaurantLabel.textColor = [UIColor blackColor];
        _restaurantLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_restaurantLabel];
        
        _etaLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 250, 20)];
        _etaLabel.textColor = [UIColor blackColor];
        _etaLabel.textAlignment = NSTextAlignmentLeft;
        _etaLabel.font = [UIFont systemFontOfSize:11];
        
        [self.contentView addSubview:_etaLabel];
        
        
        _numOrdersLabel = [[UILabel alloc]initWithFrame:CGRectMake(320, 20, 40, 30)];
        _numOrdersLabel.textColor = [UIColor blackColor];
        
        _numOrdersLabel.textAlignment = NSTextAlignmentCenter;
        _numOrdersLabel.layer.cornerRadius = 8;
        _numOrdersLabel.layer.masksToBounds = YES;
        //[_numOrdersLabel setText:@"0"];
        [self.contentView addSubview:_numOrdersLabel];
        
        
    }
    return self;
}


- (void)setEta:(int)eta {
    
    if ([self.tripStatus isEqualToString:@"active"]) {
        NSDate *etaDate = [NSDate dateWithTimeIntervalSince1970:eta];
        NSString *etaText = [NSDate stringForDisplayFromDate:etaDate prefixed:NO alwaysDisplayTime:NO];
        self.etaLabel.text = [NSString stringWithFormat:@"Arrives at %@", etaText];
    }
    
    else {
        NSDate *etaDate = [NSDate dateWithTimeIntervalSince1970:eta];
        NSString *etaText = [NSDate stringForDisplayFromDate:etaDate prefixed:NO alwaysDisplayTime:NO];
        //NSString *etaText = [NSDate stringFromDate:etaDate withFormat:@"MM-dd-yyyy"];
        self.etaLabel.text = etaText;
    }
}
- (void)setRestaurant:(NSString *)restaurant {
    self.restaurantLabel.text = restaurant;
}
- (void)setNumOrders:(int)numOrders {
    if (numOrders == 0) {
        self.numOrdersLabel.text = @"0";
        if ([self.tripStatus isEqualToString:@"active"]) {
            //grey
             self.numOrdersLabel.backgroundColor =[UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1.0f];
                   }
        else {
            //red
            self.numOrdersLabel.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1.0f];

        }
    }
    
    else {
        self.numOrdersLabel.text = [NSString stringWithFormat:@"%i", numOrders];
        if ([self.tripStatus isEqualToString:@"active"]) {
            self.numOrdersLabel.backgroundColor = [UIColor colorWithRed:180.0f/255.0f green:209.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
                    }
        else {
            self.numOrdersLabel.backgroundColor = [UIColor colorWithRed:188.0f/255.0f green:239.0f/255.0f blue:214.0f/255.0f alpha:1.0f];

        }
    }
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

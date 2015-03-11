//
//  MyTripListViewControllerCell.m
//  WolverEats
//
//  Created by Miller on 3/10/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "MyTripsListTableViewCell.h"

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
        _restaurantLabel.font = [UIFont fontWithName:@"Calibri" size:12.0f];
        [self.contentView addSubview:_restaurantLabel];
        
        _etaLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 250, 20)];
        _etaLabel.textColor = [UIColor blackColor];
        _etaLabel.textAlignment = NSTextAlignmentLeft;
        _etaLabel.font = [UIFont systemFontOfSize:10];
        
        [self.contentView addSubview:_etaLabel];
        
    }
    return self;
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

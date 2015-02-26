//
//  TripsListTableViewCell.m
//  WolverEats
//
//  Created by Cameron Cohen on 2/23/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "TripsListTableViewCell.h"

@implementation TripsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor greenColor];
        // configure control(s)
        _profView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self.contentView addSubview:_profView];
        
        _restaurantLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 100, 30)];
        _restaurantLabel.textColor = [UIColor blackColor];
        _restaurantLabel.font = [UIFont fontWithName:@"Calibri" size:12.0f];
        [self.contentView addSubview:_restaurantLabel];
        
        
        _etaLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 30)];
        _etaLabel.textColor = [UIColor blackColor];
        _etaLabel.font = [UIFont fontWithName:@"Calibri" size:12.0f];
        [self.contentView addSubview:_etaLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

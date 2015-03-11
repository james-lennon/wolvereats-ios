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
        // configure control(s)
        _profView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 30, 30)];
        _profView.layer.cornerRadius = _profView.frame.size.width / 2;
        _profView.clipsToBounds = YES;
        [self.contentView addSubview:_profView];
        
        _restaurantLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 250, 30)];
        _restaurantLabel.textColor = [UIColor blackColor];
        _restaurantLabel.font = [UIFont fontWithName:@"Calibri" size:12.0f];
        [self.contentView addSubview:_restaurantLabel];
        
        _driverName = [[UILabel alloc]initWithFrame:CGRectMake(50, 35, 250, 20)];
        _driverName.textColor = [UIColor blackColor];
        _driverName.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_driverName];
        
        
        
        _etaLabel = [[UILabel alloc] initWithFrame:CGRectMake(300, 20, 50, 30)];
        _etaLabel.textColor = [UIColor blackColor];
        _etaLabel.textAlignment = NSTextAlignmentRight;
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

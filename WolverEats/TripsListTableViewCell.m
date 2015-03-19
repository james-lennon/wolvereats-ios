//
//  TripsListTableViewCell.m
//  WolverEats
//
//  Created by Cameron Cohen on 2/23/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "TripsListTableViewCell.h"
#import "NSDate+Helper.h"

@implementation TripsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        _profView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _profView.layer.cornerRadius = _profView.frame.size.width / 2;
        _profView.clipsToBounds = YES;
        [self.contentView addSubview:_profView];
        
        _restaurantLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 250, 30)];
        _restaurantLabel.textColor = [UIColor blackColor];
        _restaurantLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_restaurantLabel];
        
        _driverName = [[UILabel alloc]initWithFrame:CGRectMake(60, 35, 250, 20)];
        _driverName.textColor = [UIColor blackColor];
        _driverName.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_driverName];
        
        
        
        _etaLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, 20, 80, 30)];
        _etaLabel.textColor = [UIColor blackColor];
        _etaLabel.textAlignment = NSTextAlignmentRight;
        _etaLabel.font = [UIFont fontWithName:@"Calibri" size:12.0f];
        [self.contentView addSubview:_etaLabel];
    }
    return self;
}

- (void)setEta:(int)eta {
    NSDate *etaDate = [NSDate dateWithTimeIntervalSince1970:eta];
    NSString *etaText = [NSDate stringForDisplayFromDate:etaDate prefixed:NO alwaysDisplayTime:NO];
    self.etaLabel.text = etaText;
}

- (void)setRestaurant:(NSString *)restaurant {
    self.restaurantLabel.text = restaurant;
}

- (void)setProfImage:(UIImage *)profImage {
    self.profView.image = profImage;
}

- (void)setName:(NSString *)name {
    self.driverName.text = name;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

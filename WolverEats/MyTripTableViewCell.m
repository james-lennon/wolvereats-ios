//
//  MyTripTableViewCell.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/16/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "MyTripTableViewCell.h"

@implementation MyTripTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont fontWithName:@"Calibri" size:12.0f];
        [self.contentView addSubview:_nameLabel];
        
        /*_etaLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 250, 20)];
        _etaLabel.textColor = [UIColor blackColor];
        _etaLabel.textAlignment = NSTextAlignmentLeft;
        _etaLabel.font = [UIFont systemFontOfSize:10];
        
        [self.contentView addSubview:_etaLabel];
         */
    }
    return self;
}

- (void)setName:(NSString *)name {
    _nameLabel.text = name;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

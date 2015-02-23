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
//        self.profView = 
//        
//        [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
//        self.descriptionLabel.textColor = [UIColor blackColor];
//        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
//        
//        [self addSubview:self.descriptionLabel];
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

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
        
        //NSLog(@"%f", self.contentView.frame.size.height);
        //(self.contentView.frame.size.height - 10)
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectZero]; // CGRectMake(20, 35, 300, (self.contentView.frame.size.height - 10))];
        _orderLabel.backgroundColor = [UIColor greenColor];
        _orderLabel.textColor = [UIColor blackColor];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
        _orderLabel.font = [UIFont systemFontOfSize:11];
        _orderLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_orderLabel];
        
    }
    return self;
}

-(void)setOrder:(NSString *)order
{
    //NSLog(@"%f", self.contentView.frame.size.height);

    self.orderLabel.text = order;
    CGRect orderLabelRect = CGRectMake(20, 35, 300, (self.contentView.frame.size.height - 40));
    _orderLabel.frame = orderLabelRect;
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

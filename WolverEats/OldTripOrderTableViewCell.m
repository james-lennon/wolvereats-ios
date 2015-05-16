//
//  OldTripOrderTableViewCell.m
//  WolverEats
//
//  Created by Miller on 4/14/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import "OldTripOrderTableViewCell.h"
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>
#import "OldTripOrdersTableViewController.h"

@implementation OldTripOrderTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont fontWithName:@"Calibri" size:12.0f];
        [self.contentView addSubview:_nameLabel];
        
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 250, 20)];
        _orderLabel.textColor = [UIColor blackColor];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
        _orderLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_orderLabel];
        
        _declineButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _declineButton.frame = CGRectMake(320, 10, 40, 40);
        _declineButton.layer.cornerRadius = 20;
        _declineButton.layer.masksToBounds = YES;
        [_declineButton addTarget:self action:@selector(declineButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _declineButton.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_declineButton];
        
        _decline = [[UIImageView alloc]initWithFrame:CGRectMake(330, 20, 20, 20)];
        _decline.image = [UIImage imageNamed:@"x.png"];
        [self.contentView addSubview:_decline];
        
        /*
         UIImage *declineImage = [UIImage imageNamed:@"x.png"];
         _declineButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
         _declineButton.imageView.bounds = CGRectMake(0, 0, 20, 20);
         [_declineButton setImage:declineImage forState:UIControlStateNormal];
         */
        
        _acceptButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _acceptButton.frame = CGRectMake(270, 10, 40, 40);
        [_acceptButton addTarget:self action:@selector(acceptButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _acceptButton.layer.cornerRadius = 20;
        _acceptButton.layer.masksToBounds = YES;
        _acceptButton.backgroundColor = [UIColor colorWithRed:188.0f/255.0f green:239.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_acceptButton];
        
        _accept = [[UIImageView alloc]initWithFrame:CGRectMake(280, 20, 20, 20)];
        _accept.image = [UIImage imageNamed:@"check.png"];
        [self.contentView addSubview:_accept];
        
    }
    
    return self;
}

-(void)setOrder:(NSString *)order
{
    self.orderLabel.text = order;
}

- (void)setName:(NSString *)name {
    _nameLabel.text = name;
}

-(void)setOrderID:(int)orderID{
    _orderID = orderID;
}

-(void)setState:(int)state
{
    if (state == 0)
    {
        _acceptButton.enabled = YES;
        _declineButton.enabled = YES;
        _acceptButton.hidden = NO;
        _declineButton.hidden = NO;
        _accept.hidden = NO;
        _decline.hidden = NO;
        _acceptButton.frame = CGRectMake(270, 10, 40, 40);
        _accept.frame = CGRectMake(280, 20, 20, 20);
        _declineButton.frame =  CGRectMake(320, 10, 40, 40);
        _decline.frame = CGRectMake(330, 20, 20, 20);
        
        
    }
    
    else if (state == 1)
    {
        
        _acceptButton.enabled = NO;
        _declineButton.enabled = NO;
        _declineButton.hidden = YES;
        _decline.hidden = YES;
        _acceptButton.hidden = NO;
        _accept.hidden = NO;
        _acceptButton.frame = CGRectMake(320, 10, 40, 40);
        _accept.frame = CGRectMake(330, 20, 20, 20);
    }
    
    else
    {
        _acceptButton.hidden = YES;
        _accept.hidden = YES;
        _acceptButton.enabled = NO;
        _declineButton.hidden = NO;
        _decline.hidden = NO;
        _declineButton.enabled = NO;
        _declineButton.frame =  CGRectMake(320, 10, 40, 40);
        _decline.frame = CGRectMake(330, 20, 20, 20);
        
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

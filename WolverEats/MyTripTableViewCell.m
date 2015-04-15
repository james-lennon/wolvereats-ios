//
//  MyTripTableViewCell.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/16/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "MyTripTableViewCell.h"
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>


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
        
        
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectZero]; // CGRectMake(20, 35, 300, (self.contentView.frame.size.height - 10))];
        _orderLabel.textColor = [UIColor colorWithRed:(30/255.0f) green:(30/255.0f) blue:(30/255.0f) alpha:1];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
        _orderLabel.font = [UIFont systemFontOfSize:11];
        _orderLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_orderLabel];

        _declineButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _declineButton.frame = CGRectMake(320, 10, 40, 40);
        _declineButton.layer.cornerRadius = 20;
        _declineButton.layer.masksToBounds = YES;
        [_declineButton addTarget:self action:@selector(declineButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _declineButton.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_declineButton];
        
        _declineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(330, 20, 20, 20)];
        _declineImageView.image = [[UIImage imageNamed:@"x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.contentView addSubview:_declineImageView];
        
        
        _acceptButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _acceptButton.frame = CGRectMake(270, 10, 40, 40);
        [_acceptButton addTarget:self action:@selector(acceptButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _acceptButton.layer.cornerRadius = 20;
        _acceptButton.layer.masksToBounds = YES;
        _acceptButton.backgroundColor = [UIColor colorWithRed:188.0f/255.0f green:239.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
        [self.contentView addSubview:_acceptButton];
        
        _acceptImageView = [[UIImageView alloc]initWithFrame:CGRectMake(280, 20, 20, 20)];
        _acceptImageView.image = [[UIImage imageNamed:@"check.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.contentView addSubview:_acceptImageView];
    
    }
    
    return self;
}


+ (CGFloat)cellHeightForOrder:(NSString *)order {
    CGSize constraint = CGSizeMake(320 - (10 * 2), 800);
    CGRect textRect = [order boundingRectWithSize:constraint
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}
                                              context:nil];
    CGFloat height = MAX(ceil(textRect.size.height), 60.0f);
    return height;
}

-(void)setOrder:(NSString *)order
{
    self.orderLabel.text = order;
    CGRect orderLabelRect = CGRectMake(22, 38, 238, [MyTripTableViewCell cellHeightForOrder:order] - 45);
    _orderLabel.frame = orderLabelRect;
}

- (void)setName:(NSString *)name {
    _nameLabel.text = name;
}

-(void)setOrderID:(int)orderID{
    _orderID = orderID;
}

-(void)setState:(int)state
{

    if (state == 0) {
        _declineImageView.hidden = NO;
        _declineButton.hidden = NO;
        _acceptButton.hidden = NO;
        _acceptImageView.hidden = NO;
        _declineImageView.frame = CGRectMake(330, 20, 20, 20);
        _declineImageView.tintColor = [UIColor blackColor];
        _acceptImageView.frame = CGRectMake(280, 20, 20, 20);
        _acceptImageView.tintColor = [UIColor blackColor];
    }
    if (state == 1)
    {
 
        _declineButton.hidden = YES;
        _acceptButton.hidden = YES;
        _declineImageView.hidden = YES;
        _acceptImageView.hidden = NO;
        _acceptImageView.frame = CGRectMake(330, 20, 20, 20);
        _acceptImageView.tintColor = [UIColor colorWithRed:0 green:(153/255.0f) blue:0 alpha:1];
    }
    
    else if (state==2)
    {
        _acceptButton.hidden = YES;
        _acceptImageView.hidden = YES;
        _declineButton.hidden = YES;
        _declineImageView.hidden = NO;
        _declineImageView.tintColor = [UIColor redColor];
    }
    
}

-(void)acceptButtonClicked{
    
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickOnAcceptOrder:)])
    {
        [self.delegate didClickOnAcceptOrder:_cellIndex];
    }
    
}

-(void)declineButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickOnDeclineOrder:)])
    {
        [self.delegate didClickOnDeclineOrder:_cellIndex]; 
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

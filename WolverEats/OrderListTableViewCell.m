//
//  OrderListTableViewCell.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "OrderListTableViewCell.h"

@implementation OrderListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        _restaurantLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 250, 30)];
        _restaurantLabel.textColor = [UIColor blackColor];
        _restaurantLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_restaurantLabel];
        
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 250, 20)];
        _orderLabel.textColor = [UIColor blackColor];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
        _orderLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_orderLabel];
        
        _orderStatus = [[UIImageView alloc]initWithFrame:CGRectMake(335, 20, 20, 20)];
        [self.contentView addSubview:_orderStatus];
        //_exclamation.layer.cornerRadius = _exclamation.frame.size.width / 2;
        //_exclamation.clipsToBounds = YES;
        //_exclamation.backgroundColor = [UIColor whiteColor];
        

 
        
        /*
        _numOrdersLabel.textColor = [UIColor blackColor];
        _numOrdersLabel.textAlignment = NSTextAlignmentCenter;
        _numOrdersLabel.layer.cornerRadius = 8;
        _numOrdersLabel.layer.masksToBounds = YES;
        //[_numOrdersLabel setText:@"0"];
     
        */
        
    }
    return self;
}


- (void)setRestaurant:(NSString *)restaurant {
    self.restaurantLabel.text = restaurant;
}

-(void)setOrderText:(NSString *)orderText
{
    self.orderLabel.text = orderText; 
}

-(void)setOrderState:(int)orderState
{
    if (orderState == 1) {
        
    self.orderStatus.image = [UIImage imageNamed:@"check.png"];
    }
    if (orderState == 0)
    {
    self.orderStatus.image = [UIImage imageNamed:@"x.png"];
    }
    
}



@end

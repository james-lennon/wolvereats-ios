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
        
        _colorStatus = [[UIImageView alloc]initWithFrame:CGRectMake(320, 10, 40, 40)];
        _colorStatus.layer.cornerRadius = 20;
        _colorStatus.layer.masksToBounds = YES;
        [self.contentView addSubview:_colorStatus];
       
        _orderStatus = [[UIImageView alloc]initWithFrame:CGRectMake(330, 20, 20, 20)];
        [self.contentView addSubview:_orderStatus];
        

        

 
        
     
        
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
    if (orderState == 0)
    {
        self.orderStatus.image = [UIImage imageNamed:@"pending.png"];
        //grey
        self.colorStatus.backgroundColor = [UIColor colorWithRed:228.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1.0f];
    }
    else if (orderState == 1) {
        
        self.orderStatus.image = [UIImage imageNamed:@"check.png"];
        //green
        self.colorStatus.backgroundColor = [UIColor colorWithRed:188.0f/255.0f green:239.0f/255.0f blue:214.0f/255.0f alpha:1.0f];
    }
    else
     
    {
       self.orderStatus.image = [UIImage imageNamed:@"x.png"];
       //red
        self.colorStatus.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1.0f];
    }
    
}



@end

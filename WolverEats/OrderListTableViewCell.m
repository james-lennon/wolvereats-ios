//
//  OrderListTableViewCell.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/3/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
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
        
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _orderLabel.textColor = [UIColor colorWithRed:(30/255.0f) green:(30/255.0f) blue:(30/255.0f) alpha:1];
        _orderLabel.textAlignment = NSTextAlignmentLeft;
        _orderLabel.font = [UIFont systemFontOfSize:11];
        _orderLabel.numberOfLines = 0;
        [self.contentView addSubview:_orderLabel];
        
        _colorStatus = [[UIImageView alloc]initWithFrame:CGRectMake(320, 10, 40, 40)];
        [self.contentView addSubview:_colorStatus];
       
        _orderStatus = [[UIImageView alloc]initWithFrame:CGRectMake(330, 20, 20, 20)];
        [self.contentView addSubview:_orderStatus];
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


- (void)setRestaurant:(NSString *)restaurant {
    self.restaurantLabel.text = restaurant;
}

-(void)setOrderText:(NSString *)orderText
{
    self.orderLabel.text = orderText;
    CGRect orderLabelRect = CGRectMake(22, 38, 260, [OrderListTableViewCell cellHeightForOrder:orderText] - 45);
    _orderLabel.frame = orderLabelRect;

}

-(void)setOrderState:(int)orderState
{
    if (orderState == 0)
    {
        self.orderStatus.image = [[UIImage imageNamed:@"pending.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.orderStatus.tintColor = [UIColor blackColor];
    }
    else if (orderState == 1) {
        self.orderStatus.image = [[UIImage imageNamed:@"check.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _orderStatus.tintColor = [UIColor colorWithRed:0 green:(153/255.0f) blue:0 alpha:1];
    }
    else
    {
       self.orderStatus.image = [[UIImage imageNamed:@"x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.orderStatus.tintColor = [UIColor redColor];
    }
}



@end

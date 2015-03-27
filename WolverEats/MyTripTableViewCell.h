//
//  MyTripTableViewCell.h
//  WolverEats
//
//  Created by Cameron Cohen on 3/16/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTripTableViewCellDelegate <NSObject>
- (void)didClickOnAcceptOrder:(NSInteger)cellIndex;
-(void)didClickOnDeclineOrder:(NSInteger)cellIndex;
@end

@interface MyTripTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property(nonatomic, strong) UIButton *acceptButton;
@property(nonatomic, strong) UIButton *declineButton;
@property(nonatomic, strong)UIImageView *acceptImageView;
@property(nonatomic, strong)UIImageView *declineImageView;

@property(nonatomic ) NSString *name;
@property(nonatomic, strong) NSString *order;
@property(nonatomic) int orderID;
@property(nonatomic) int state; 

@property (weak, nonatomic) id<MyTripTableViewCellDelegate> delegate;
@property (assign, nonatomic)   NSInteger cellIndex;

+ (CGFloat)cellHeightForOrder:(NSString *)order;


@end

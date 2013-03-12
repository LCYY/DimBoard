//
//  RecordCell.m
//  DimBoard
//
//  Created by conicacui on 28/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell
@synthesize m_cellController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        m_cellController = nil;
    }
    return self;
}

-(void)setName:(NSString *)name Term:(NSString *)term MonthlyPay:(NSString *)pay Progress:(float)progress{
    if(m_cellController == nil){
        m_cellController = [[RecordCellViewController alloc] init];
        [self.contentView addSubview:m_cellController.view];
    }
    [m_cellController setName:name Term:term MonthlyPay:pay Progress:progress];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  GridCell.m
//  DimBoard
//
//  Created by conicacui on 27/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "GridCell.h"

@implementation GridCell
@synthesize m_cellController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setTerm:(NSInteger)term MonthlyPay:(double)monthlypay Principal:(double)principal Interest:(double)interest LeftAmount:(double)amount{
    if(m_cellController == nil){
        m_cellController = [[GridCellViewController alloc] init];
        [self.contentView addSubview:m_cellController.view];
    }
    [m_cellController setTerm:term MonthlyPay:monthlypay Principal:principal Interest:interest LeftAmount:amount];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

}

@end

//
//  PieChartCell.m
//  DimBoard
//
//  Created by conicacui on 22/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import "PieChartCell.h"

@implementation PieChartCell
@synthesize m_cellController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Slices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        m_cellController = [[PieChartCellViewController alloc] init];
        [self.contentView addSubview:m_cellController.view];
    }
    return self;
}

-(void)reloadData{
    if(m_cellController){
        [m_cellController reloadData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    return;
}

@end
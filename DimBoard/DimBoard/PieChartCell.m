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
@synthesize m_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithSlices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath *)indexpath{
    self = [super init];
    if(self){
        m_cellController = [[PieChartCellViewController alloc] initWithSlices:slices Descriptions:desps Colors:nil IndexPath:indexpath];
        [m_cellController setM_delegate:self];
        [self.contentView addSubview:m_cellController.view];
    }
    return self;
}

-(void)setSlices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath *)indexpath{
    if(m_cellController){
        [m_cellController setSlices:slices Descriptions:desps Colors:colors IndexPath:indexpath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];
}

-(CGFloat)getHeight{
    if(m_cellController)
        return [m_cellController getHeight];
    return 45;
}

# pragma mark - PieChartCellExtendDelegate
- (void)extendPieChartCell:(BOOL)extend atIndexPath:(NSIndexPath *)indexpath{
    [m_delegate extendPieChartCell:extend atIndexPath:indexpath];
}

@end

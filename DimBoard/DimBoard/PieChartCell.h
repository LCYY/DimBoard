//
//  PieChartCell.h
//  DimBoard
//
//  Created by conicacui on 22/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartCellViewController.h"

@interface PieChartCell : UITableViewCell<PieChartCellExtendDelegate>
@property (retain, nonatomic) PieChartCellViewController* m_cellController;
@property (retain, nonatomic) id<PieChartCellExtendDelegate> m_delegate;

-(id)initWithSlices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath*)indexpath;
-(void)setSlices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath*)indexpath;
-(CGFloat)getHeight;
@end

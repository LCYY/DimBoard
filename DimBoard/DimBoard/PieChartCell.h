//
//  PieChartCell.h
//  DimBoard
//
//  Created by conicacui on 22/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartCellViewController.h"

@interface PieChartCell : UITableViewCell

@property (retain, nonatomic) PieChartCellViewController* m_cellController;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Slices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors;
-(void)reloadData;
@end

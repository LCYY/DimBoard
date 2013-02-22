//
//  PieChartCellViewController.h
//  DimBoard
//
//  Created by conicacui on 22/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart/XYPieChart.h"

@interface PieChartCellViewController : UIViewController<XYPieChartDataSource,XYPieChartDelegate>
{
    NSArray *m_sliceColors;
    NSInteger m_selectedSliceIndex;

}
@property (weak, nonatomic) IBOutlet UILabel *PieChartSlice_output;
@property (weak, nonatomic) IBOutlet XYPieChart *PieChart;
@property (retain, nonatomic) NSMutableArray *m_slices;
@property (retain, nonatomic) NSMutableArray *m_slicesDesp;

-(id)initWithSlices:(NSArray *)slices Descriptions:(NSArray *)desps Colors:(NSArray*)colors;
-(void)reloadData;
@end

//
//  PieChartCellViewController.h
//  DimBoard
//
//  Created by conicacui on 22/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart/XYPieChart.h"
#import "DimBoardNotifications.h"
#import <QuartzCore/QuartzCore.h>

@protocol PieChartCellExtendDelegate <NSObject>

-(void)extendPieChartCell:(BOOL)extend atIndexPath:(NSIndexPath*)indexpath;

@end


@interface PieChartCellViewController : UIViewController<XYPieChartDataSource,XYPieChartDelegate>
{
    NSArray *m_sliceColors;
    NSInteger m_selectedSliceIndex;
    BOOL m_extend;
    NSInteger m_height;
}
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *PieChartSlice_output;
@property (weak, nonatomic) IBOutlet XYPieChart *PieChart;
@property (weak, nonatomic) IBOutlet UIButton *ExtendButton;
@property (weak, nonatomic) IBOutlet UIButton *ColorLabel_1;
@property (weak, nonatomic) IBOutlet UIButton *ColorLabel_2;
@property (weak, nonatomic) IBOutlet UIButton *ColorLabel_3;
@property (weak, nonatomic) IBOutlet UIButton *ColorLabel_4;
@property (weak, nonatomic) IBOutlet UIButton *ColorLabel_5;


@property (retain, nonatomic) NSMutableArray *m_slices;
@property (retain, nonatomic) NSMutableArray *m_slicesDesp;
@property (retain, nonatomic) NSIndexPath* m_indexPath;
@property (retain, nonatomic) NSArray *m_colorLabels;
@property (retain, nonatomic) id<PieChartCellExtendDelegate>m_delegate;

-(id)initWithSlices:(NSArray *)slices Descriptions:(NSArray *)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath*)indexpath;
-(void)setSlices:(NSArray*)slices Descriptions:(NSArray*)desps Colors:(NSArray*)colors IndexPath:(NSIndexPath*)indexpath;
-(CGFloat)getHeight;
- (IBAction)toggleExtendStatus:(id)sender;
@end

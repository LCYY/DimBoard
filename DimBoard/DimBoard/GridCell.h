//
//  GridCell.h
//  DimBoard
//
//  Created by conicacui on 27/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridCellViewController.h"

@interface GridCell : UITableViewCell

@property (retain, nonatomic) GridCellViewController* m_cellController;

-(void)setTerm:(NSInteger)term MonthlyPay:(double)monthlypay Principal:(double)principal Interest:(double)interest LeftAmount:(double)amount Row:(NSInteger)row;
@end

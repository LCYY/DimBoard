//
//  RecordCell.h
//  DimBoard
//
//  Created by conicacui on 28/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordCellViewController.h"

@interface RecordCell : UITableViewCell

@property (retain, nonatomic) RecordCellViewController* m_cellController;

-(void)setName:(NSString*)name Term:(NSString*)term Date:(NSString*)date Progress:(float)progress;
@end

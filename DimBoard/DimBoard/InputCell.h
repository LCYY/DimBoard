//
//  InputCell.h
//  DimBoard
//
//  Created by conicacui on 19/2/13.
//  Copyright (c) 2013 LCYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputCellViewController.h"

@interface InputCell : UITableViewCell

@property (nonatomic, retain) InputCellViewController *m_cellController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Name:(NSString *)name Value:(NSString *)value;
- (void) setName:(NSString *)name Value:(NSString *)value;
@end
